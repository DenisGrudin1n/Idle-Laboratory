import 'dart:async';

import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/statistics_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class StatisticsService {
  StatisticsService(this._repository) {
    _initialize();
  }

  final StatisticsRepository _repository;
  final BehaviorSubject<StatisticsModel> _statsSubject = BehaviorSubject<StatisticsModel>.seeded(
    StatisticsModel.initial(),
  );

  /// Wall-clock start of the current active session (cold start or resume).
  DateTime? _sessionStartedAt;

  /// Last time playtime seconds were flushed into [StatisticsModel.totalPlayTimeSeconds].
  DateTime? _lastPlaytimeFlushAt;

  Timer? _saveTimer;
  StatisticsModel? _pendingSave;

  Stream<StatisticsModel> get statistics$ => _statsSubject.stream;
  StatisticsModel get current => _statsSubject.value;

  void _initialize() {
    _load().then(_statsSubject.add).catchError((_) => _statsSubject.add(StatisticsModel.initial()));
  }

  Future<StatisticsModel> _load() async {
    final saved = await _repository.getStatistics();
    return saved ?? StatisticsModel.initial();
  }

  /// Cold-start session: increments session count and starts playtime segment.
  void start() {
    final now = DateTime.now();
    var next = current;
    if (next.firstLaunchEpochMs == null) {
      next = next.copyWith(firstLaunchEpochMs: now.millisecondsSinceEpoch);
    }
    next = next.copyWith(sessionsStarted: next.sessionsStarted + 1);
    _sessionStartedAt = now;
    _lastPlaytimeFlushAt = now;
    _emit(next);
    _scheduleSave(next);
  }

  void pausePlaytime() => _flushPlaytime(endSession: true);

  void resumePlaytime() {
    if (_sessionStartedAt != null) return;
    final now = DateTime.now();
    _sessionStartedAt = now;
    _lastPlaytimeFlushAt = now;
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
    _emit(next);
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
    _emit(next);
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
    _emit(next);
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
    _emit(next);
    save();
  }

  void _emit(StatisticsModel next) => _statsSubject.add(next);

  void _flushPlaytime({required bool endSession}) {
    final lastFlush = _lastPlaytimeFlushAt;
    final sessionStart = _sessionStartedAt;
    if (lastFlush == null || sessionStart == null) return;

    final now = DateTime.now();
    final elapsedSinceFlush = now.difference(lastFlush).inSeconds;
    final sessionLength = now.difference(sessionStart).inSeconds;

    var next = current;
    if (elapsedSinceFlush > 0) {
      next = next.copyWith(totalPlayTimeSeconds: next.totalPlayTimeSeconds + elapsedSinceFlush);
    }
    if (sessionLength > next.longestSessionSeconds) {
      next = next.copyWith(longestSessionSeconds: sessionLength);
    }

    if (endSession) {
      _sessionStartedAt = null;
      _lastPlaytimeFlushAt = null;
    } else {
      _lastPlaytimeFlushAt = now;
    }

    if (next != current) _emit(next);
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
        await _repository.saveStatistics(current);
      });

  @disposeMethod
  void dispose() {
    _flushPlaytime(endSession: true);
    _saveTimer?.cancel();
    unawaited(_repository.saveStatistics(current));
    _statsSubject.close();
  }
}
