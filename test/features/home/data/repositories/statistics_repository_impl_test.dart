import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/statistics_repository_impl.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalStorageDataSource extends Mock implements LocalStorageDataSource {}

void main() {
  late _MockLocalStorageDataSource dataSource;
  late StatisticsRepositoryImpl repository;

  setUp(() {
    dataSource = _MockLocalStorageDataSource();
    repository = StatisticsRepositoryImpl(dataSource);
  });

  test('getStatistics returns null when the key is absent', () async {
    when(() => dataSource.getString(StorageKeys.statisticsState)).thenReturn(null);

    expect(await repository.getStatistics(), isNull);
    verify(() => dataSource.getString(StorageKeys.statisticsState)).called(1);
  });

  test('saveStatistics and getStatistics round-trip the statistics blob', () async {
    String? stored;
    when(() => dataSource.setString(StorageKeys.statisticsState, any())).thenAnswer((invocation) async {
      stored = invocation.positionalArguments[1] as String;
      return true;
    });
    when(() => dataSource.getString(StorageKeys.statisticsState)).thenAnswer((_) => stored);

    final model = StatisticsModel.initial().copyWith(
      totalPlayTimeSeconds: 120,
      sessionsStarted: 3,
      lifetimeEnergyGenerated: BigNumber(5, 2),
      lifetimeCellsProducedByType: {CellId.basicEnergyCell.id: BigNumber(1, 1)},
      lifetimeMaterialsCraftedByType: {ResearchMaterialId.energyCore.name: 4},
      firstLaunchEpochMs: 1_700_000_000_000,
    );

    await repository.saveStatistics(model);

    final loaded = await repository.getStatistics();
    expect(loaded, isNotNull);
    expect(loaded!.totalPlayTimeSeconds, 120);
    expect(loaded.sessionsStarted, 3);
    expect(loaded.lifetimeEnergyGenerated, BigNumber(5, 2));
    expect(loaded.lifetimeCellsProducedByType[CellId.basicEnergyCell.id], BigNumber(1, 1));
    expect(loaded.lifetimeMaterialsCraftedByType[ResearchMaterialId.energyCore.name], 4);
    expect(loaded.firstLaunchEpochMs, 1_700_000_000_000);
    expect(jsonDecode(stored!), model.toJson());
    verify(() => dataSource.setString(StorageKeys.statisticsState, any())).called(1);
  });

  test('clearAll removes the statistics key', () async {
    when(() => dataSource.remove(StorageKeys.statisticsState)).thenAnswer((_) async => true);

    await repository.clearAll();

    verify(() => dataSource.remove(StorageKeys.statisticsState)).called(1);
  });
}
