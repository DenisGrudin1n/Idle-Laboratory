import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/constants/game_errors.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/extensions/research_material_l10n_ext.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_production_entry/cell_production_entry.dart';
import 'package:idle_laboratory/features/home/domain/services/cells_service.dart';
import 'package:idle_laboratory/features/home/domain/services/crafting_service.dart';
import 'package:idle_laboratory/features/home/domain/services/energy_service.dart';
import 'package:idle_laboratory/features/home/domain/services/statistics_service.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockCellsService extends Mock implements CellsService {}

class _MockEnergyService extends Mock implements EnergyService {}

class _MockStorageService extends Mock implements StorageService {}

class _MockStatisticsService extends Mock implements StatisticsService {}

void main() {
  late _MockCellsService cellsService;
  late _MockEnergyService energyService;
  late _MockStorageService storageService;
  late _MockStatisticsService statisticsService;

  const cellId = CellId.basicEnergyCell;
  const unit = Duration(seconds: GameBalance.craftingDurationSeconds);

  setUpAll(() {
    registerFallbackValue(BigNumber.zero());
    registerFallbackValue(cellId);
    registerFallbackValue(ResearchMaterialId.energyCore);
  });

  setUp(() {
    cellsService = _MockCellsService();
    energyService = _MockEnergyService();
    storageService = _MockStorageService();
    statisticsService = _MockStatisticsService();

    when(() => energyService.currentEnergy).thenReturn(BigNumber(1, 6));
    when(() => energyService.trySpendEnergy(any())).thenReturn(true);
    when(() => cellsService.currentProduction).thenReturn({
      cellId.id: CellProductionEntry.initial(cellId.id).copyWith(amount: BigNumber(1, 12)),
    });
    when(() => cellsService.trySpendCells(any(), any())).thenReturn(true);
    when(() => storageService.hasMaterial(any(), count: any(named: 'count'))).thenReturn(false);
  });

  CraftingService build() => CraftingService(cellsService, energyService, storageService, statisticsService);

  test('outputFor maps a cell slot to its base research material', () {
    final service = build();
    addTearDown(service.dispose);
    expect(service.outputFor(cellId: cellId), cellId.baseResearchMaterial);
    expect(service.outputFor(reagent1Id: ResearchMaterialId.energyCore), isNull);
  });

  test('validate reports missing energy for the whole batch', () {
    when(() => energyService.currentEnergy).thenReturn(BigNumber(9, 0));
    final service = build();
    addTearDown(service.dispose);

    expect(service.validate(quantity: 1, cellId: cellId), isNull);
    expect(service.validate(quantity: 2, cellId: cellId), GameErrors.craftingNotEnoughEnergy);
  });

  testWidgets('reaction spends inputs, outputs material and records stats per unit', (tester) async {
    final service = build();
    addTearDown(service.dispose);
    final output = cellId.baseResearchMaterial!;

    expect(service.start(quantity: 2, cellId: cellId), isTrue);
    expect(service.currentReaction.isCrafting, isTrue);
    expect(service.currentReaction.remaining, 2);

    await tester.pump(unit);
    verify(() => storageService.addMaterial(output)).called(1);
    verify(
      () => statisticsService.recordCraftCompleted(
        materialId: output,
        energySpent: any(named: 'energySpent'),
        durationSeconds: GameBalance.craftingDurationSeconds,
      ),
    ).called(1);
    expect(service.currentReaction.remaining, 1);
    expect(service.currentReaction.isCrafting, isTrue);

    await tester.pump(unit);
    verify(() => storageService.addMaterial(output)).called(1);
    expect(service.currentReaction.isCrafting, isFalse);
    expect(service.currentReaction.remaining, 0);
  });

  testWidgets('reaction pauses with remaining quantity when inputs run out', (tester) async {
    final service = build();
    addTearDown(service.dispose);

    service.start(quantity: 3, cellId: cellId);
    when(() => energyService.currentEnergy).thenReturn(BigNumber.zero());

    await tester.pump(unit);
    verifyNever(() => storageService.addMaterial(any()));
    expect(service.currentReaction.isCrafting, isFalse);
    expect(service.currentReaction.remaining, 3);
  });

  testWidgets('stop keeps remaining quantity and halts ticking', (tester) async {
    final service = build();
    addTearDown(service.dispose);

    service.start(quantity: 2, cellId: cellId);
    await tester.pump(const Duration(seconds: 1));
    service.stop();
    await tester.pump(unit * 2);

    verifyNever(() => storageService.addMaterial(any()));
    expect(service.currentReaction.isCrafting, isFalse);
    expect(service.currentReaction.progress, 0);
    expect(service.currentReaction.remaining, 2);
  });
}
