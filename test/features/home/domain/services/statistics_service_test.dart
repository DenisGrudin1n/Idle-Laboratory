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
    );

    final restored = StatisticsModel.fromJson(model.toJson());
    expect(restored.totalPlayTimeSeconds, 120);
    expect(restored.sessionsStarted, 3);
    expect(restored.lifetimeEnergyGenerated, BigNumber(5, 2));
    expect(restored.lifetimeCellsProducedByType[CellId.basicEnergyCell.id], BigNumber(1, 1));
    expect(restored.lifetimeMaterialsCraftedByType[ResearchMaterialId.energyCore.name], 4);
  });

  test('start seeds first launch and increments sessions', () async {
    await Future<void>.delayed(Duration.zero);
    service.start();
    expect(service.current.sessionsStarted, 1);
    expect(service.current.firstLaunchEpochMs, isNotNull);

    service.start();
    expect(service.current.sessionsStarted, 2);
    expect(service.current.firstLaunchEpochMs, isNotNull);
  });

  test('recordEnergyGenerated updates lifetime, this-run, and peaks', () async {
    await Future<void>.delayed(Duration.zero);
    service.recordEnergyGenerated(
      BigNumber(10, 0),
      currentEnergy: BigNumber(10, 0),
      currentEps: BigNumber(2, 0),
    );

    expect(service.current.lifetimeEnergyGenerated, BigNumber(10, 0));
    expect(service.current.energyEarnedThisPrestigeRun, BigNumber(10, 0));
    expect(service.current.peakEnergy, BigNumber(10, 0));
    expect(service.current.peakEps, BigNumber(2, 0));
  });

  test('recordPrestige resets this-run energy and tracks best run', () async {
    await Future<void>.delayed(Duration.zero);
    service.recordEnergyGenerated(
      BigNumber(50, 0),
      currentEnergy: BigNumber(50, 0),
      currentEps: BigNumber.zero(),
    );
    service.recordPrestige(
      energyAtPrestige: BigNumber(50, 0),
      newTotalMultiplier: BigNumber(3, 0),
    );

    expect(service.current.energyEarnedThisPrestigeRun, BigNumber.zero());
    expect(service.current.energyAtLastPrestige, BigNumber(50, 0));
    expect(service.current.bestPrestigeRunEnergy, BigNumber(50, 0));
    expect(service.current.highestPrestigeMultiplier, BigNumber(3, 0));
  });

  test('recordCellsProduced accumulates total and per type', () async {
    await Future<void>.delayed(Duration.zero);
    service.recordCellsProduced({
      CellId.basicEnergyCell: BigNumber(4, 0),
      CellId.heatCell: BigNumber(2, 0),
    });

    expect(service.current.lifetimeCellsProduced, BigNumber(6, 0));
    expect(service.current.lifetimeCellsProducedByType[CellId.basicEnergyCell.id], BigNumber(4, 0));
    expect(service.current.lifetimeCellsProducedByType[CellId.heatCell.id], BigNumber(2, 0));
  });

  test('recordCraftCompleted tracks materials and energy', () async {
    await Future<void>.delayed(Duration.zero);
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
}
