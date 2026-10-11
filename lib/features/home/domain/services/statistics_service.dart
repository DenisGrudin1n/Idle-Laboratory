import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/persistence_labels.dart';
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
  /// [now] is test-only (clock injection); ignored by GetIt / injectable.
  StatisticsService(this._repository, {@ignoreParam DateTime Function()? now}) : _now = now ?? DateTime.now {
    _loadFuture = _initialize();
  }

  final DateTime Function() _now;

  final StatisticsRepository _repository;
  final BehaviorSubject<StatisticsModel> _statsSubject = BehaviorSubject<StatisticsModel>.seeded(
    StatisticsModel.initial(),
  );

  /// Folded model; read through [current] so pending hot-tick deltas are applied.
  StatisticsModel _current = StatisticsModel.initial();

  /// 100ms-tick deltas accumulated in place; folded into [_current] on read.
  final _PendingTickStats _pending = _PendingTickStats();

  /// Completes after the first load from storage (success or fallback).
  late final Future<void> _loadFuture;

  /// Wall-clock start of the current active session (cold start or resume).
  DateTime? _sessionStartedAt;

  /// Last time playtime seconds were flushed into [StatisticsModel.totalPlayTimeSeconds].
  DateTime? _lastPlaytimeFlushAt;

  Timer? _saveTimer;
  Timer? _playtimeTimer;
  Timer? _playtimePersistTimer;
  Timer? _notifyTimer;
  Duration? _playtimeTickInterval;
  bool _started = false;
  bool _sessionCounted = false;
  bool _inForeground = true;
  bool _loaded = false;
  bool _disposed = false;

  /// Writers that arrived before [_load] finished. Replayed onto the saved
  /// model so a slow prefs read cannot replace them with the snapshot.
  final List<void Function()> _beforeLoad = [];

  /// UI-facing stream: distinct + coalesced for hot paths (see [_emit]).
  Stream<StatisticsModel> get statistics$ => _statsSubject.stream.distinct();

  /// Always-current model for writers / persistence (may be ahead of [statistics$]).
  StatisticsModel get current {
    if (_pending.isDirty) {
      _current = _pending.applyTo(_current);
      _pending.clear();
    }
    return _current;
  }

  /// Derived from [current.firstLaunchEpochMs] using the service clock.
  int get daysSinceFirstLaunch => current.daysSinceFirstLaunch(_now());

  Future<void> _initialize() async {
    StatisticsModel loaded;
    try {
      loaded = await _load();
    } catch (error, stackTrace) {
      developer.log(
        '${PersistenceLabels.statisticsLoad} failed, starting from empty statistics',
        name: 'idle_laboratory',
        error: error,
        stackTrace: stackTrace,
      );
      loaded = StatisticsModel.initial();
    }

    _current = loaded;
    _loaded = true;
    _replayBeforeLoad();
    _publish(current);
  }

  void _replayBeforeLoad() {
    final queued = List<void Function()>.of(_beforeLoad);
    _beforeLoad.clear();
    for (final write in queued) {
      write();
    }
  }

  /// Runs [write] once the saved ledger is in memory.
  /// Cold paths only — hot ticks check [_loaded] inline to avoid a closure.
  void _afterLoad(void Function() write) {
    if (_loaded) {
      write();
      return;
    }
    _beforeLoad.add(write);
  }

  void _publish(StatisticsModel model) {
    if (_disposed || _statsSubject.isClosed || _statsSubject.value == model) return;
    _statsSubject.add(model);
  }

  Future<StatisticsModel> _load() async {
    final saved = await _repository.getStatistics();
    return saved ?? StatisticsModel.initial();
  }

  /// Cold-start session: increments session count and starts playtime segment.
  /// Called once per app process by `AppLifecycleService`.
  ///
  /// Awaits the initial storage load so a late `_load` cannot overwrite the
  /// session increment / first-launch stamp.
  Future<void> start() async {
    if (_started) return;
    _started = true;
    await _loadFuture;
    if (_disposed) return;

    final now = _now();
    var next = current;
    if (next.firstLaunchEpochMs == null) {
      next = next.copyWith(firstLaunchEpochMs: now.millisecondsSinceEpoch);
    }
    next = next.copyWith(sessionsStarted: next.sessionsStarted + 1);
    _sessionCounted = true;
    _emit(next, urgent: true);
    _scheduleSave();
    if (_inForeground) _beginPlaytimeSegment(now);
  }

  void pausePlaytime() {
    _inForeground = false;
    _stopPlaytimeTicker();
    _flushPlaytime(endSession: true);
  }

  /// No-op until [start] has counted the session; [start] then opens the segment.
  void resumePlaytime() {
    _inForeground = true;
    if (!_sessionCounted || _sessionStartedAt != null) return;
    _beginPlaytimeSegment(_now());
  }

  void _beginPlaytimeSegment(DateTime now) {
    _sessionStartedAt = now;
    _lastPlaytimeFlushAt = now;
    _restartPlaytimeTicker();
  }

  void syncPlaytimeClock() {
    if (!_sessionCounted || _disposed) return;
    _inForeground = true;
    if (_sessionStartedAt == null) {
      _beginPlaytimeSegment(_now());
      return;
    }
    _flushPlaytime(endSession: false);
    _restartPlaytimeTicker();
  }

  /// Hot path (every energy tick): accumulates in place, no model copy.
  void recordEnergyGenerated(BigNumber amount, {required BigNumber currentEnergy, required BigNumber currentEps}) {
    if (amount <= BigNumber.zero()) return;
    if (!_loaded) {
      _beforeLoad.add(
        () => recordEnergyGenerated(amount, currentEnergy: currentEnergy, currentEps: currentEps),
      );
      return;
    }
    _pending
      ..energyGenerated = _pending.energyGenerated + amount
      ..isDirty = true;
    if (currentEnergy > (_pending.peakEnergy ?? _current.peakEnergy)) {
      _pending.peakEnergy = currentEnergy;
    }
    if (currentEps > (_pending.peakEps ?? _current.peakEps)) {
      _pending.peakEps = currentEps;
    }
    _markHotChange();
  }

  void recordEnergySpent(BigNumber amount) {
    if (amount <= BigNumber.zero()) return;
    _afterLoad(() => _recordEnergySpent(amount));
  }

  void _recordEnergySpent(BigNumber amount) {
    final next = current.copyWith(lifetimeEnergySpent: current.lifetimeEnergySpent + amount);
    _emit(next);
    _scheduleSave();
  }

  void recordPeakEps(BigNumber eps) {
    _afterLoad(() => _recordPeakEps(eps));
  }

  void _recordPeakEps(BigNumber eps) {
    if (eps <= current.peakEps) return;
    final next = current.copyWith(peakEps: eps);
    _emit(next);
    _scheduleSave();
  }

  /// Hot path (every production tick): accumulates in place, no model copy.
  void recordProductionTick(Map<CellId, BigNumber> deltas) {
    if (!_loaded) {
      if (!_hasPositiveDelta(deltas)) return;
      final snapshot = Map<CellId, BigNumber>.of(deltas);
      _beforeLoad.add(() => recordProductionTick(snapshot));
      return;
    }
    var changed = false;
    for (final entry in deltas.entries) {
      if (entry.value <= BigNumber.zero()) continue;
      changed = true;
      final key = entry.key.id;
      _pending
        ..cellsProduced = _pending.cellsProduced + entry.value
        ..cellsProducedByType[key] = (_pending.cellsProducedByType[key] ?? BigNumber.zero()) + entry.value;
    }
    if (!changed) return;
    _pending.isDirty = true;
    _markHotChange();
  }

  bool _hasPositiveDelta(Map<CellId, BigNumber> deltas) {
    for (final value in deltas.values) {
      if (value > BigNumber.zero()) return true;
    }
    return false;
  }

  void recordCellLevelUps(int levels, {required int totalCellLevels}) {
    _afterLoad(() => _recordCellLevelUps(levels, totalCellLevels: totalCellLevels));
  }

  void _recordCellLevelUps(int levels, {required int totalCellLevels}) {
    if (levels <= 0 && totalCellLevels <= current.peakTotalCellLevels) return;
    final next = current.copyWith(
      lifetimeCellLevelUps: current.lifetimeCellLevelUps + (levels > 0 ? levels : 0),
      peakTotalCellLevels: totalCellLevels > current.peakTotalCellLevels
          ? totalCellLevels
          : current.peakTotalCellLevels,
    );
    _emit(next, urgent: true);
    _scheduleSave();
  }

  void recordProductionLevelUps(int levels, {required int totalProductionLevels}) {
    _afterLoad(() => _recordProductionLevelUps(levels, totalProductionLevels: totalProductionLevels));
  }

  void _recordProductionLevelUps(int levels, {required int totalProductionLevels}) {
    if (levels <= 0 && totalProductionLevels <= current.peakTotalProductionLevels) return;
    final next = current.copyWith(
      lifetimeProductionLevelUps: current.lifetimeProductionLevelUps + (levels > 0 ? levels : 0),
      peakTotalProductionLevels: totalProductionLevels > current.peakTotalProductionLevels
          ? totalProductionLevels
          : current.peakTotalProductionLevels,
    );
    _emit(next, urgent: true);
    _scheduleSave();
  }

  void recordCraftCompleted({
    required ResearchMaterialId materialId,
    required BigNumber energySpent,
    required int durationSeconds,
  }) {
    _afterLoad(
      () => _recordCraftCompleted(materialId: materialId, energySpent: energySpent, durationSeconds: durationSeconds),
    );
  }

  void _recordCraftCompleted({
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
    _scheduleSave();
  }

  void recordPrestige({required BigNumber energyAtPrestige, required BigNumber newTotalMultiplier}) {
    _afterLoad(() => _recordPrestige(energyAtPrestige: energyAtPrestige, newTotalMultiplier: newTotalMultiplier));
  }

  void _recordPrestige({required BigNumber energyAtPrestige, required BigNumber newTotalMultiplier}) {
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
    fireAndForget(save(), label: PersistenceLabels.statisticsSave);
  }

  /// Clears run-scoped fields on any run reset (prestige or full prestige reset).
  void resetRun() {
    _afterLoad(_resetRun);
  }

  void _resetRun() {
    if (current.energyEarnedThisPrestigeRun == BigNumber.zero()) return;
    final next = current.copyWith(energyEarnedThisPrestigeRun: BigNumber.zero());
    _emit(next, urgent: true);
    _scheduleSave();
  }

  /// Updates [_current] immediately. Hot paths coalesce [statistics$] notifies;
  /// [urgent] flushes the stream right away (prestige, craft, playtime, start).
  void _emit(StatisticsModel next, {bool urgent = false}) {
    _current = next;
    if (_disposed) return;
    if (urgent) {
      _flushNotify();
      return;
    }
    _scheduleNotify();
  }

  void _markHotChange() {
    _scheduleNotify();
    _scheduleSave();
  }

  void _scheduleNotify() {
    if (!_loaded || _disposed) return;
    _notifyTimer ??= Timer(
      const Duration(milliseconds: GameBalance.statisticsUiEmitThrottleMs),
      _flushNotify,
    );
  }

  void _flushNotify() {
    _notifyTimer?.cancel();
    _notifyTimer = null;
    _publish(current);
  }

  int get _effectivePlayTimeSeconds {
    final lastFlush = _lastPlaytimeFlushAt;
    final base = current.totalPlayTimeSeconds;
    if (lastFlush == null || _sessionStartedAt == null) return base;
    return base + _now().difference(lastFlush).inSeconds;
  }

  int get _sessionLengthSeconds {
    final sessionStart = _sessionStartedAt;
    if (sessionStart == null) return 0;
    return _now().difference(sessionStart).inSeconds;
  }

  Duration _nextPlaytimeTickInterval() => PlayTimeScaleExt.tickFor(
        totalPlayTimeSeconds: _effectivePlayTimeSeconds,
        sessionSeconds: _sessionLengthSeconds,
      );

  void _restartPlaytimeTicker() {
    _stopPlaytimeTicker();
    if (_sessionStartedAt == null) return;
    final interval = _nextPlaytimeTickInterval();
    _playtimeTickInterval = interval;
    _playtimeTimer = Timer.periodic(interval, (_) => _onPlaytimeTick());
    _playtimePersistTimer = Timer.periodic(
      const Duration(milliseconds: GameBalance.statisticsPlaytimePersistIntervalMs),
      (_) => _onPlaytimePersistTick(),
    );
  }

  void _stopPlaytimeTicker() {
    _playtimeTimer?.cancel();
    _playtimeTimer = null;
    _playtimePersistTimer?.cancel();
    _playtimePersistTimer = null;
    _playtimeTickInterval = null;
  }

  void _onPlaytimeTick() {
    _flushPlaytime(endSession: false);
    _scheduleSave();
    final nextInterval = _nextPlaytimeTickInterval();
    if (nextInterval != _playtimeTickInterval) {
      _restartPlaytimeTicker();
    }
  }

  /// Saves unflushed playtime without touching [_current], so the UI only
  /// changes on the adaptive display tick.
  void _onPlaytimePersistTick() => _scheduleSave();

  /// [model] plus the playtime elapsed since the last display flush.
  StatisticsModel _withUnflushedPlaytime(StatisticsModel model) {
    final lastFlush = _lastPlaytimeFlushAt;
    final sessionStart = _sessionStartedAt;
    if (lastFlush == null || sessionStart == null) return model;
    final now = _now();
    return model.copyWith(
      totalPlayTimeSeconds: model.totalPlayTimeSeconds + now.difference(lastFlush).inSeconds,
      longestSessionSeconds: math.max(model.longestSessionSeconds, now.difference(sessionStart).inSeconds),
    );
  }

  void _flushPlaytime({required bool endSession}) {
    final lastFlush = _lastPlaytimeFlushAt;
    final sessionStart = _sessionStartedAt;
    if (lastFlush == null || sessionStart == null) return;

    final now = _now();
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

  /// Debounced autosave of [current] (including unflushed playtime).
  void _scheduleSave() {
    if (!_loaded || _disposed || _saveTimer != null) return;
    _saveTimer = Timer(const Duration(milliseconds: GameBalance.energyAutoSaveDurationMs), () {
      _saveTimer = null;
      fireAndForget(_autosave(), label: PersistenceLabels.statisticsAutosave);
    });
  }

  /// Persists playtime that is not yet on [_current], so the UI still ticks
  /// on the adaptive display interval.
  Future<void> _autosave() => guardAsync(() async {
        if (!_loaded) await _loadFuture;
        if (_disposed) return;
        await _repository.saveStatistics(_withUnflushedPlaytime(current));
      });

  Future<void> save() => guardAsync(() async {
        if (!_loaded) await _loadFuture;
        if (_disposed) return;
        _flushPlaytime(endSession: false);
        _flushNotify();
        await _repository.saveStatistics(current);
      });

  @disposeMethod
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _stopPlaytimeTicker();
    _notifyTimer?.cancel();
    _notifyTimer = null;
    _saveTimer?.cancel();
    _saveTimer = null;
    _flushPlaytime(endSession: true);
    fireAndForget(_saveAfterLoad(), label: PersistenceLabels.statisticsDispose);
    _statsSubject.close();
  }

  Future<void> _saveAfterLoad() async {
    if (!_loaded) await _loadFuture;
    await _repository.saveStatistics(current);
  }
}

/// Mutable 100ms-tick accumulator owned by [StatisticsService].
///
/// Stays service-private on purpose: it is not a persisted or UI model, so it
/// does not belong in `domain/models` and must not be generated with Freezed.
class _PendingTickStats {
  bool isDirty = false;
  BigNumber energyGenerated = BigNumber.zero();
  BigNumber? peakEnergy;
  BigNumber? peakEps;
  BigNumber cellsProduced = BigNumber.zero();
  final Map<String, BigNumber> cellsProducedByType = {};

  StatisticsModel applyTo(StatisticsModel model) {
    final peakEnergy = this.peakEnergy;
    final peakEps = this.peakEps;
    final byType = cellsProducedByType.isEmpty
        ? model.lifetimeCellsProducedByType
        : {
            ...model.lifetimeCellsProducedByType,
            for (final entry in cellsProducedByType.entries)
              entry.key: (model.lifetimeCellsProducedByType[entry.key] ?? BigNumber.zero()) + entry.value,
          };
    return model.copyWith(
      lifetimeEnergyGenerated: model.lifetimeEnergyGenerated + energyGenerated,
      energyEarnedThisPrestigeRun: model.energyEarnedThisPrestigeRun + energyGenerated,
      peakEnergy: peakEnergy != null && peakEnergy > model.peakEnergy ? peakEnergy : model.peakEnergy,
      peakEps: peakEps != null && peakEps > model.peakEps ? peakEps : model.peakEps,
      lifetimeCellsProduced: model.lifetimeCellsProduced + cellsProduced,
      lifetimeCellsProducedByType: byType,
    );
  }

  void clear() {
    isDirty = false;
    energyGenerated = BigNumber.zero();
    peakEnergy = null;
    peakEps = null;
    cellsProduced = BigNumber.zero();
    cellsProducedByType.clear();
  }
}
