import 'dart:async';

import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/core/extensions/play_time_scale_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/statistics_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class StatisticsService {
  StatisticsService(this._repository) {
    _loadFuture = _initialize();
  }

  final StatisticsRepository _repository;
  final BehaviorSubject<StatisticsModel> _statsSubject = BehaviorSubject<StatisticsModel>.seeded(
    StatisticsModel.initial(),
  );

  /// Always-current model for writers / persistence (may be ahead of [statistics$]).
  StatisticsModel _current = StatisticsModel.initial();

  /// Completes after the first load from storage (success or fallback).
  late final Future<void> _loadFuture;

  /// Wall-clock start of the current active session (cold start or resume).
  DateTime? _sessionStartedAt;

  /// Last time playtime seconds were flushed into [StatisticsModel.totalPlayTimeSeconds].
  DateTime? _lastPlaytimeFlushAt;

  Timer? _saveTimer;
  Timer? _playtimeTimer;
  Timer? _notifyTimer;
  Duration? _playtimeTickInterval;
  StatisticsModel? _pendingSave;
  bool _started = false;

  /// UI-facing stream: distinct + coalesced for hot paths (see [_emit]).
  Stream<StatisticsModel> get statistics$ => _statsSubject.stream.distinct();

  StatisticsModel get current => _current;

  Future<void> _initialize() async {
    try {
      final saved = await _load();
      _current = saved;
      _statsSubject.add(saved);
    } catch (_) {
      _current = StatisticsModel.initial();
      _statsSubject.add(_current);
    }
  }

  Future<StatisticsModel> _load() async {
    final saved = await _repository.getStatistics();
    return saved ?? StatisticsModel.initial();
  }

  /// Cold-start session: increments session count and starts playtime segment.
  ///
  /// Awaits the initial storage load so a late `_load` cannot overwrite the
  /// session increment / first-launch stamp.
  Future<void> start() async {
    await _loadFuture;
    if (_started && _sessionStartedAt != null) return;

    final now = DateTime.now();
    var next = current;
    if (next.firstLaunchEpochMs == null) {
      next = next.copyWith(firstLaunchEpochMs: now.millisecondsSinceEpoch);
    }
    next = next.copyWith(sessionsStarted: next.sessionsStarted + 1);
    _started = true;
    _sessionStartedAt = now;
    _lastPlaytimeFlushAt = now;
    _emit(next, urgent: true);
    _scheduleSave(next);
    _restartPlaytimeTicker();
  }

  void pausePlaytime() {
    _stopPlaytimeTicker();
    _flushPlaytime(endSession: true);
  }

  void resumePlaytime() {
    if (_sessionStartedAt != null) return;
    final now = DateTime.now();
    _sessionStartedAt = now;
    _lastPlaytimeFlushAt = now;
    _restartPlaytimeTicker();
  }

  void recordEnergyGenerated(BigNumber amount, {required BigNumber currentEnergy, required BigNumber currentEps}) {
    if (amount <= BigNumber.zero()) return;
    var next = current.copyWith(
      lifetimeEnergyGenerated: current.lifetimeEnergyGenerated + amount,
      energyEarnedThisPrestigeRun: current.energyEarnedThisPrestigeRun + amount,
    );
    if (currentEnergy > next.peakEnergy) {
      next = next.copyWith(peakEnergy: currentEnergy);
    }
    if (currentEps > next.peakEps) {
      next = next.copyWith(peakEps: currentEps);
    }
    _emit(next);
    _scheduleSave(next);
  }

  void recordEnergySpent(BigNumber amount) {
    if (amount <= BigNumber.zero()) return;
    final next = current.copyWith(lifetimeEnergySpent: current.lifetimeEnergySpent + amount);
    _emit(next);
    _scheduleSave(next);
  }

  void recordPeakEps(BigNumber eps) {
    if (eps <= current.peakEps) return;
    final next = current.copyWith(peakEps: eps);
    _emit(next);
    _scheduleSave(next);
  }

  void recordCellsProduced(Map<CellId, BigNumber> deltas) {
    if (deltas.isEmpty) return;
    var total = current.lifetimeCellsProduced;
    final byType = Map<String, BigNumber>.from(current.lifetimeCellsProducedByType);
    var changed = false;
    for (final entry in deltas.entries) {
      if (entry.value <= BigNumber.zero()) continue;
      changed = true;
      total = total + entry.value;
      final key = entry.key.id;
      byType[key] = (byType[key] ?? BigNumber.zero()) + entry.value;
    }
    if (!changed) return;
    final next = current.copyWith(lifetimeCellsProduced: total, lifetimeCellsProducedByType: byType);
    _emit(next);
    _scheduleSave(next);
  }

  void recordCellLevelUps(int levels, {required int totalCellLevels}) {
    if (levels <= 0 && totalCellLevels <= current.peakTotalCellLevels) return;
    final next = current.copyWith(
      lifetimeCellLevelUps: current.lifetimeCellLevelUps + (levels > 0 ? levels : 0),
      peakTotalCellLevels: totalCellLevels > current.peakTotalCellLevels
          ? totalCellLevels
          : current.peakTotalCellLevels,
    );
    _emit(next, urgent: true);
    _scheduleSave(next);
  }

  void recordProductionGenerated(Map<CellId, BigNumber> deltas) {
    if (deltas.isEmpty) return;
    var total = current.lifetimeProductionGenerated;
    final byType = Map<String, BigNumber>.from(current.lifetimeProductionGeneratedByType);
    var changed = false;
    for (final entry in deltas.entries) {
      if (entry.value <= BigNumber.zero()) continue;
      changed = true;
      total = total + entry.value;
      final key = entry.key.id;
      byType[key] = (byType[key] ?? BigNumber.zero()) + entry.value;
    }
    if (!changed) return;
    final next = current.copyWith(lifetimeProductionGenerated: total, lifetimeProductionGeneratedByType: byType);
    _emit(next);
    _scheduleSave(next);
  }

  void recordProductionLevelUps(int levels, {required int totalProductionLevels}) {
    if (levels <= 0 && totalProductionLevels <= current.peakTotalProductionLevels) return;
    final next = current.copyWith(
      lifetimeProductionLevelUps: current.lifetimeProductionLevelUps + (levels > 0 ? levels : 0),
      peakTotalProductionLevels: totalProductionLevels > current.peakTotalProductionLevels
          ? totalProductionLevels
          : current.peakTotalProductionLevels,
    );
    _emit(next, urgent: true);
    _scheduleSave(next);
  }

  void recordCraftCompleted({
    required ResearchMaterialId materialId,
    required BigNumber energySpent,
    required int durationSeconds,
  }) {
    final byType = Map<String, int>.from(current.lifetimeMaterialsCraftedByType);
    final key = materialId.name;
    byType[key] = (byType[key] ?? 0) + 1;
    final next = current.copyWith(
      lifetimeCraftsCompleted: current.lifetimeCraftsCompleted + 1,
      lifetimeMaterialsCrafted: current.lifetimeMaterialsCrafted + 1,
      lifetimeMaterialsCraftedByType: byType,
      lifetimeCraftEnergySpent: current.lifetimeCraftEnergySpent + energySpent,
      lifetimeCraftDurationSeconds: current.lifetimeCraftDurationSeconds + durationSeconds,
    );
    _emit(next, urgent: true);
    _scheduleSave(next);
  }

  void recordPrestige({required BigNumber energyAtPrestige, required BigNumber newTotalMultiplier}) {
    var next = current.copyWith(
      energyAtLastPrestige: energyAtPrestige,
      energyEarnedThisPrestigeRun: BigNumber.zero(),
    );
    if (newTotalMultiplier > next.highestPrestigeMultiplier) {
      next = next.copyWith(highestPrestigeMultiplier: newTotalMultiplier);
    }
    if (energyAtPrestige > next.bestPrestigeRunEnergy) {
      next = next.copyWith(bestPrestigeRunEnergy: energyAtPrestige);
    }
    _emit(next, urgent: true);
    save();
  }

  /// Updates [_current] immediately. Hot paths coalesce [statistics$] notifies;
  /// [urgent] flushes the stream right away (prestige, craft, playtime, start).
  void _emit(StatisticsModel next, {bool urgent = false}) {
    _current = next;
    if (urgent) {
      _flushNotify();
      return;
    }
    _notifyTimer ??= Timer(
      const Duration(milliseconds: GameBalance.statisticsUiEmitThrottleMs),
      _flushNotify,
    );
  }

  void _flushNotify() {
    _notifyTimer?.cancel();
    _notifyTimer = null;
    if (!_statsSubject.isClosed && _statsSubject.value != _current) {
      _statsSubject.add(_current);
    }
  }

  int get _effectivePlayTimeSeconds {
    final lastFlush = _lastPlaytimeFlushAt;
    final base = current.totalPlayTimeSeconds;
    if (lastFlush == null || _sessionStartedAt == null) return base;
    return base + DateTime.now().difference(lastFlush).inSeconds;
  }

  void _restartPlaytimeTicker() {
    _stopPlaytimeTicker();
    if (_sessionStartedAt == null) return;
    final interval = PlayTimeScaleExt.forSeconds(_effectivePlayTimeSeconds).tickInterval;
    _playtimeTickInterval = interval;
    _playtimeTimer = Timer.periodic(interval, (_) => _onPlaytimeTick());
  }

  void _stopPlaytimeTicker() {
    _playtimeTimer?.cancel();
    _playtimeTimer = null;
    _playtimeTickInterval = null;
  }

  void _onPlaytimeTick() {
    _flushPlaytime(endSession: false);
    _scheduleSave(current);
    final nextInterval = PlayTimeScaleExt.forSeconds(current.totalPlayTimeSeconds).tickInterval;
    if (nextInterval != _playtimeTickInterval) {
      _restartPlaytimeTicker();
    }
  }

  void _flushPlaytime({required bool endSession}) {
    final lastFlush = _lastPlaytimeFlushAt;
    final sessionStart = _sessionStartedAt;
    if (lastFlush == null || sessionStart == null) return;

    final now = DateTime.now();
    final elapsedMs = now.difference(lastFlush).inMilliseconds;
    final wholeSeconds = elapsedMs ~/ 1000;
    final sessionLength = now.difference(sessionStart).inSeconds;

    var next = current;
    if (wholeSeconds > 0) {
      next = next.copyWith(totalPlayTimeSeconds: next.totalPlayTimeSeconds + wholeSeconds);
    }
    if (sessionLength > next.longestSessionSeconds) {
      next = next.copyWith(longestSessionSeconds: sessionLength);
    }

    if (endSession) {
      _sessionStartedAt = null;
      _lastPlaytimeFlushAt = null;
    } else if (wholeSeconds > 0) {
      _lastPlaytimeFlushAt = lastFlush.add(Duration(seconds: wholeSeconds));
    }

    if (next != current) {
      _emit(next, urgent: true);
    }
  }

  void _scheduleSave(StatisticsModel model) {
    _pendingSave = model;
    if (_saveTimer != null) return;
    _saveTimer = Timer(const Duration(milliseconds: GameBalance.energyAutoSaveDurationMs), () {
      final pending = _pendingSave;
      _pendingSave = null;
      _saveTimer = null;
      if (pending != null) {
        unawaited(_repository.saveStatistics(pending));
      }
    });
  }

  Future<void> save() => guardAsync(() async {
        _flushPlaytime(endSession: false);
        _flushNotify();
        await _repository.saveStatistics(current);
      });

  @disposeMethod
  void dispose() {
    _stopPlaytimeTicker();
    _flushPlaytime(endSession: true);
    _flushNotify();
    _saveTimer?.cancel();
    unawaited(_repository.saveStatistics(current));
    _statsSubject.close();
  }
}
