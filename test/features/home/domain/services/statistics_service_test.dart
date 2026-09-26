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
      ..recordCellsProduced({CellId.basicEnergyCell: BigNumber(3, 0)})
      ..recordPrestige(energyAtPrestige: BigNumber(50, 0), newTotalMultiplier: BigNumber(3, 0));

    expect(service.current.energyEarnedThisPrestigeRun, BigNumber.zero());
    expect(service.current.energyAtLastPrestige, BigNumber(50, 0));
    expect(service.current.bestPrestigeRunEnergy, BigNumber(50, 0));
    expect(service.current.highestPrestigeMultiplier, BigNumber(3, 0));
    expect(service.current.lifetimeEnergyGenerated, BigNumber(50, 0));
    expect(service.current.lifetimeCellsProduced, BigNumber(3, 0));
    verify(() => repository.saveStatistics(any())).called(greaterThan(0));
  });

  test('recordCellsProduced accumulates total and per type', () async {
    await service.start();
    service.recordCellsProduced({CellId.basicEnergyCell: BigNumber(4, 0), CellId.heatCell: BigNumber(2, 0)});

    expect(service.current.lifetimeCellsProduced, BigNumber(6, 0));
    expect(service.current.lifetimeCellsProducedByType[CellId.basicEnergyCell.id], BigNumber(4, 0));
    expect(service.current.lifetimeCellsProducedByType[CellId.heatCell.id], BigNumber(2, 0));
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
}
