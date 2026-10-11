import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/repositories/statistics_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:idle_laboratory/features/home/domain/services/statistics_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockStatisticsRepository extends Mock implements StatisticsRepository {}

void main() {
  late _MockStatisticsRepository repository;
  late StatisticsService service;

  setUpAll(() {
    registerFallbackValue(StatisticsModel.initial());
  });

  setUp(() {
    repository = _MockStatisticsRepository();
    when(() => repository.getStatistics()).thenAnswer((_) async => null);
    when(() => repository.saveStatistics(any())).thenAnswer((_) async {});
    service = StatisticsService(repository);
  });

  tearDown(() {
    service.dispose();
  });

  test('StatisticsModel round-trips through json', () {
    final model = StatisticsModel.initial().copyWith(
      totalPlayTimeSeconds: 120,
      sessionsStarted: 3,
      lifetimeEnergyGenerated: BigNumber(5, 2),
      lifetimeCellsProducedByType: {CellId.basicEnergyCell.id: BigNumber(1, 1)},
      lifetimeMaterialsCraftedByType: {ResearchMaterialId.energyCore.name: 4},
      energyEarnedThisPrestigeRun: BigNumber(9, 0),
      firstLaunchEpochMs: 1_700_000_000_000,
    );

    final restored = StatisticsModel.fromJson(model.toJson());
    expect(restored.totalPlayTimeSeconds, 120);
    expect(restored.sessionsStarted, 3);
    expect(restored.lifetimeEnergyGenerated, BigNumber(5, 2));
    expect(restored.lifetimeCellsProducedByType[CellId.basicEnergyCell.id], BigNumber(1, 1));
    expect(restored.lifetimeMaterialsCraftedByType[ResearchMaterialId.energyCore.name], 4);
    expect(restored.energyEarnedThisPrestigeRun, BigNumber(9, 0));
    expect(restored.firstLaunchEpochMs, 1_700_000_000_000);
  });

  test('start seeds first launch and increments sessions once', () async {
    await service.start();
    expect(service.current.sessionsStarted, 1);
    expect(service.current.firstLaunchEpochMs, isNotNull);

    final firstLaunch = service.current.firstLaunchEpochMs;
    await service.start();
    expect(service.current.sessionsStarted, 1);
    expect(service.current.firstLaunchEpochMs, firstLaunch);
  });

  test('start after load preserves saved lifetime stats and bumps session', () async {
    final saved = StatisticsModel.initial().copyWith(
      sessionsStarted: 4,
      totalPlayTimeSeconds: 90,
      lifetimeEnergyGenerated: BigNumber(100, 0),
      firstLaunchEpochMs: 1_600_000_000_000,
      peakEnergy: BigNumber(50, 0),
    );
    when(() => repository.getStatistics()).thenAnswer((_) async => saved);

    final fresh = StatisticsService(repository);
    addTearDown(fresh.dispose);

    await fresh.start();

    expect(fresh.current.sessionsStarted, 5);
    expect(fresh.current.totalPlayTimeSeconds, 90);
    expect(fresh.current.lifetimeEnergyGenerated, BigNumber(100, 0));
    expect(fresh.current.peakEnergy, BigNumber(50, 0));
    expect(fresh.current.firstLaunchEpochMs, 1_600_000_000_000);
  });

  test('recordEnergyGenerated updates lifetime, this-run, and peaks', () async {
    await service.start();
    service.recordEnergyGenerated(BigNumber(10, 0), currentEnergy: BigNumber(10, 0), currentEps: BigNumber(2, 0));

    expect(service.current.lifetimeEnergyGenerated, BigNumber(10, 0));
    expect(service.current.energyEarnedThisPrestigeRun, BigNumber(10, 0));
    expect(service.current.peakEnergy, BigNumber(10, 0));
    expect(service.current.peakEps, BigNumber(2, 0));
  });

  test('recordPrestige resets this-run energy and keeps lifetime fields', () async {
    await service.start();
    service
      ..recordEnergyGenerated(BigNumber(50, 0), currentEnergy: BigNumber(50, 0), currentEps: BigNumber.zero())
      ..recordProductionTick({CellId.basicEnergyCell: BigNumber(3, 0)})
      ..recordPrestige(energyAtPrestige: BigNumber(50, 0), newTotalMultiplier: BigNumber(3, 0));

    expect(service.current.energyEarnedThisPrestigeRun, BigNumber.zero());
    expect(service.current.energyAtLastPrestige, BigNumber(50, 0));
    expect(service.current.bestPrestigeRunEnergy, BigNumber(50, 0));
    expect(service.current.highestPrestigeMultiplier, BigNumber(3, 0));
    expect(service.current.lifetimeEnergyGenerated, BigNumber(50, 0));
    expect(service.current.lifetimeCellsProduced, BigNumber(3, 0));
    verify(() => repository.saveStatistics(any())).called(greaterThan(0));
  });

  test('resetRun clears this-run energy and keeps lifetime fields', () async {
    await service.start();
    service
      ..recordEnergyGenerated(BigNumber(20, 0), currentEnergy: BigNumber(20, 0), currentEps: BigNumber.zero())
      ..resetRun();

    expect(service.current.energyEarnedThisPrestigeRun, BigNumber.zero());
    expect(service.current.lifetimeEnergyGenerated, BigNumber(20, 0));
  });

  test('load failure falls back to initial statistics', () async {
    when(() => repository.getStatistics()).thenThrow(Exception('corrupt blob'));
    final fresh = StatisticsService(repository);
    addTearDown(fresh.dispose);

    await fresh.start();

    expect(fresh.current.sessionsStarted, 1);
    expect(fresh.current.lifetimeEnergyGenerated, BigNumber.zero());
  });

  test('recordProductionTick accumulates cells produced total and per type', () async {
    await service.start();
    service.recordProductionTick({
      CellId.basicEnergyCell: BigNumber(4, 0),
      CellId.heatCell: BigNumber(2, 0),
      CellId.plasmaCell: BigNumber.zero(),
    });

    expect(service.current.lifetimeCellsProduced, BigNumber(6, 0));
    expect(service.current.lifetimeCellsProducedByType[CellId.basicEnergyCell.id], BigNumber(4, 0));
    expect(service.current.lifetimeCellsProducedByType[CellId.heatCell.id], BigNumber(2, 0));
    expect(service.current.lifetimeCellsProducedByType.containsKey(CellId.plasmaCell.id), isFalse);
  });

  test('recordProductionTick ignores ticks with no positive deltas', () async {
    await service.start();
    final before = service.current;
    service.recordProductionTick({CellId.basicEnergyCell: BigNumber.zero()});

    expect(identical(service.current, before), isTrue);
  });

  test('recordCraftCompleted tracks materials and energy', () async {
    await service.start();
    service.recordCraftCompleted(
      materialId: ResearchMaterialId.bloodDrop,
      energySpent: BigNumber(5, 0),
      durationSeconds: 5,
    );

    expect(service.current.lifetimeCraftsCompleted, 1);
    expect(service.current.lifetimeMaterialsCrafted, 1);
    expect(service.current.lifetimeMaterialsCraftedByType[ResearchMaterialId.bloodDrop.name], 1);
    expect(service.current.lifetimeCraftEnergySpent, BigNumber(5, 0));
    expect(service.current.lifetimeCraftDurationSeconds, 5);
  });

  test('pause flushes playtime into total and longest session', () async {
    await service.start();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    service.pausePlaytime();

    expect(service.current.totalPlayTimeSeconds, greaterThanOrEqualTo(1));
    expect(service.current.longestSessionSeconds, greaterThanOrEqualTo(1));
  });

  test('resume after pause continues accumulating playtime', () async {
    await service.start();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    service.pausePlaytime();
    final afterPause = service.current.totalPlayTimeSeconds;

    service.resumePlaytime();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    service.pausePlaytime();

    expect(service.current.totalPlayTimeSeconds, greaterThanOrEqualTo(afterPause + 1));
  });

  test('resumePlaytime before start does not open a playtime segment', () async {
    service.resumePlaytime();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    service.pausePlaytime();

    expect(service.current.totalPlayTimeSeconds, 0);
    expect(service.current.sessionsStarted, 0);
  });

  test('backgrounded during load: session counted, playtime waits for resume', () async {
    final pendingLoad = Completer<StatisticsModel?>();
    when(() => repository.getStatistics()).thenAnswer((_) => pendingLoad.future);
    final fresh = StatisticsService(repository);
    addTearDown(fresh.dispose);

    final started = fresh.start();
    fresh.pausePlaytime();
    pendingLoad.complete(null);
    await started;

    expect(fresh.current.sessionsStarted, 1);
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    fresh.pausePlaytime();
    expect(fresh.current.totalPlayTimeSeconds, 0);

    fresh.resumePlaytime();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    fresh.pausePlaytime();
    expect(fresh.current.totalPlayTimeSeconds, greaterThanOrEqualTo(1));
  });

  test('hot ticks accumulate across many calls and fold peaks correctly', () async {
    await service.start();
    for (var i = 1; i <= 10; i++) {
      service
        ..recordEnergyGenerated(BigNumber(1, 0), currentEnergy: BigNumber(i.toDouble(), 0), currentEps: BigNumber(1, 0))
        ..recordProductionTick({CellId.basicEnergyCell: BigNumber(2, 0)});
    }
    expect(service.current.lifetimeEnergyGenerated.toDouble(), closeTo(10, 1e-9));
    expect(service.current.peakEnergy, BigNumber(10, 0));

    service.recordEnergyGenerated(BigNumber(1, 0), currentEnergy: BigNumber(3, 0), currentEps: BigNumber(1, 0));
    expect(service.current.peakEnergy, BigNumber(10, 0));
    expect(service.current.lifetimeEnergyGenerated.toDouble(), closeTo(11, 1e-9));
    expect(service.current.lifetimeCellsProduced.toDouble(), closeTo(20, 1e-9));
    expect(service.current.lifetimeCellsProducedByType[CellId.basicEnergyCell.id]!.toDouble(), closeTo(20, 1e-9));
  });

  test('daysSinceFirstLaunch derives whole days from first launch', () {
    final first = DateTime(2026, 1, 1, 12);
    final model = StatisticsModel.initial().copyWith(firstLaunchEpochMs: first.millisecondsSinceEpoch);
    expect(model.daysSinceFirstLaunch(first.add(const Duration(days: 3, hours: 5))), 3);
    expect(StatisticsModel.initial().daysSinceFirstLaunch(first), 0);
  });

  test(r'statistics$ throttles hot energy updates but current stays live', () async {
    await service.start();
    final emissions = <StatisticsModel>[];
    final sub = service.statistics$.skip(1).listen(emissions.add);
    addTearDown(sub.cancel);

    for (var i = 0; i < 5; i++) {
      service.recordEnergyGenerated(
        BigNumber(1, 0),
        currentEnergy: BigNumber(i + 1, 0),
        currentEps: BigNumber(1, 0),
      );
    }

    expect(service.current.lifetimeEnergyGenerated, BigNumber(5, 0));
    expect(emissions, isEmpty);

    await Future<void>.delayed(const Duration(milliseconds: 1100));
    expect(emissions, isNotEmpty);
    expect(emissions.last.lifetimeEnergyGenerated, BigNumber(5, 0));
  });

  test('writes that arrive before storage load merge onto the saved ledger', () async {
    final saved = StatisticsModel.initial().copyWith(
      sessionsStarted: 4,
      firstLaunchEpochMs: 1_600_000_000_000,
      lifetimeEnergyGenerated: BigNumber(100, 0),
      peakEnergy: BigNumber(80, 0),
      peakEps: BigNumber(5, 0),
      lifetimeCellsProduced: BigNumber(10, 0),
      lifetimeCellsProducedByType: {CellId.basicEnergyCell.id: BigNumber(10, 0)},
    );
    final gate = Completer<StatisticsModel?>();
    when(() => repository.getStatistics()).thenAnswer((_) => gate.future);

    final fresh = StatisticsService(repository);
    addTearDown(fresh.dispose);

    fresh.recordPeakEps(BigNumber(9, 0));
    for (var i = 0; i < 3; i++) {
      fresh
        ..recordEnergyGenerated(
          BigNumber(1, 0),
          currentEnergy: BigNumber((91 + i).toDouble(), 0),
          currentEps: BigNumber(9, 0),
        )
        ..recordProductionTick({CellId.basicEnergyCell: BigNumber(2, 0)});
    }

    expect(fresh.current.lifetimeEnergyGenerated, BigNumber.zero());
    verifyNever(() => repository.saveStatistics(any()));

    final persisted = fresh.save();
    gate.complete(saved);
    await persisted;

    final written = verify(() => repository.saveStatistics(captureAny())).captured.single as StatisticsModel;
    expect(written.lifetimeEnergyGenerated.toDouble(), closeTo(103, 1e-9));
    expect(written.peakEnergy, BigNumber(93, 0));
    expect(written.peakEps, BigNumber(9, 0));
    expect(written.lifetimeCellsProduced.toDouble(), closeTo(16, 1e-9));
    expect(written.lifetimeCellsProducedByType[CellId.basicEnergyCell.id]!.toDouble(), closeTo(16, 1e-9));
    expect(written.sessionsStarted, 4);
    expect(written.firstLaunchEpochMs, 1_600_000_000_000);

    await fresh.start();
    expect(fresh.current.sessionsStarted, 5);
    expect(fresh.current.lifetimeEnergyGenerated.toDouble(), closeTo(103, 1e-9));
    expect(fresh.current.firstLaunchEpochMs, 1_600_000_000_000);
  });

  test('playtime and longest session keep moving through hours', () {
    fakeAsync((async) {
      var now = DateTime.utc(2026, 10, 11, 12);
      final fresh = StatisticsService(repository, now: () => now);
      addTearDown(fresh.dispose);

      unawaited(fresh.start());
      async.flushMicrotasks();

      now = now.add(const Duration(hours: 1));
      async.elapse(const Duration(hours: 1));
      expect(fresh.current.totalPlayTimeSeconds, 3600);
      expect(fresh.current.longestSessionSeconds, 3600);

      now = now.add(const Duration(minutes: 15));
      async.elapse(const Duration(minutes: 15));
      expect(fresh.current.totalPlayTimeSeconds, 3600 + 15 * 60);
      expect(fresh.current.longestSessionSeconds, 3600 + 15 * 60);

      now = now.add(const Duration(hours: 2));
      async.elapse(const Duration(hours: 2));
      expect(fresh.current.totalPlayTimeSeconds, 3 * 3600 + 15 * 60);
      expect(fresh.current.longestSessionSeconds, 3 * 3600 + 15 * 60);

      fresh.dispose();
    });
  });

  test('a new session still accumulates when lifetime play is already in days', () {
    fakeAsync((async) {
      var now = DateTime.utc(2026, 10, 11, 12);
      when(() => repository.getStatistics()).thenAnswer(
        (_) async => StatisticsModel.initial().copyWith(
          totalPlayTimeSeconds: 2 * 86400,
          longestSessionSeconds: 10 * 60,
          sessionsStarted: 4,
          firstLaunchEpochMs: 1_600_000_000_000,
        ),
      );
      final fresh = StatisticsService(repository, now: () => now);
      addTearDown(fresh.dispose);

      unawaited(fresh.start());
      async.flushMicrotasks();

      now = now.add(const Duration(minutes: 12));
      async.elapse(const Duration(minutes: 12));

      expect(fresh.current.totalPlayTimeSeconds, 2 * 86400 + 12 * 60);
      expect(fresh.current.longestSessionSeconds, 12 * 60);
      expect(fresh.current.sessionsStarted, 5);

      fresh.dispose();
    });
  });

  test('syncPlaytimeClock applies time that the display timer has not flushed yet', () {
    fakeAsync((async) {
      var now = DateTime.utc(2026, 10, 11, 12);
      final fresh = StatisticsService(repository, now: () => now);
      addTearDown(fresh.dispose);

      unawaited(fresh.start());
      async.flushMicrotasks();

      now = now.add(const Duration(hours: 1, minutes: 4));
      async.elapse(const Duration(hours: 1, minutes: 4));
      expect(fresh.current.totalPlayTimeSeconds, 3600 + 4 * 60);

      now = now.add(const Duration(minutes: 15));
      fresh.syncPlaytimeClock();

      expect(fresh.current.totalPlayTimeSeconds, 3600 + 19 * 60);
      expect(fresh.current.longestSessionSeconds, 3600 + 19 * 60);

      fresh.dispose();
    });
  });

  test('save without ending the session keeps accumulating wall-clock playtime', () {
    fakeAsync((async) {
      var now = DateTime.utc(2026, 10, 11, 12);
      final fresh = StatisticsService(repository, now: () => now);
      addTearDown(fresh.dispose);

      unawaited(fresh.start());
      async.flushMicrotasks();

      now = now.add(const Duration(minutes: 5));
      unawaited(fresh.save());
      async.flushMicrotasks();
      expect(fresh.current.totalPlayTimeSeconds, 5 * 60);

      now = now.add(const Duration(minutes: 10));
      fresh.syncPlaytimeClock();
      expect(fresh.current.totalPlayTimeSeconds, 15 * 60);
      expect(fresh.current.longestSessionSeconds, 15 * 60);

      fresh.dispose();
    });
  });

  test('syncPlaytimeClock reopens a stopped session and resumes ticking', () {
    fakeAsync((async) {
      var now = DateTime.utc(2026, 10, 11, 12);
      final fresh = StatisticsService(repository, now: () => now);
      addTearDown(fresh.dispose);

      unawaited(fresh.start());
      async.flushMicrotasks();

      now = now.add(const Duration(minutes: 2));
      async.elapse(const Duration(minutes: 2));
      fresh.pausePlaytime();
      final pausedAt = fresh.current.totalPlayTimeSeconds;
      expect(pausedAt, 2 * 60);

      now = now.add(const Duration(minutes: 10));
      fresh.syncPlaytimeClock();

      now = now.add(const Duration(minutes: 3));
      async.elapse(const Duration(minutes: 3));
      expect(fresh.current.totalPlayTimeSeconds, pausedAt + 3 * 60);

      fresh.dispose();
    });
  });
}
