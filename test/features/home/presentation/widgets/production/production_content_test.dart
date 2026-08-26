import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/production/production_content.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/production_test_fixtures.dart';
import '../../../../../helpers/production_widget_test_harness.dart';

void main() {
  late MockCellsBloc cellsBloc;
  late MockAppLayoutBloc appLayoutBloc;
  late MockPrestigeBloc prestigeBloc;
  late ProductionWidgetTestHarness harness;

  setUpAll(() {
    registerFallbackValue(const CellsEvent.start());
    registerFallbackValue(const AppLayoutEvent.appVersionChanged(AppVersionEnum.mobile));
    registerFallbackValue(const PrestigeEvent.start());
  });

  setUp(() {
    cellsBloc = MockCellsBloc();
    appLayoutBloc = MockAppLayoutBloc();
    prestigeBloc = MockPrestigeBloc();
    harness = ProductionWidgetTestHarness(
      cellsBloc: cellsBloc,
      appLayoutBloc: appLayoutBloc,
      prestigeBloc: prestigeBloc,
    );
  });

  tearDown(() {
    harness.dispose();
  });

  testWidgets('renders production grid for unlocked cells', (tester) async {
    harness.init(
      cellsState: testCellsState(cells: defaultTestCells()),
      prestigeState: testPrestigeState(),
    );

    await tester.pumpWidget(harness.wrap(const ProductionContent()));
    await tester.pump();

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(GestureDetector), findsWidgets);
  });

  testWidgets('shows updated production amount after bloc emission', (tester) async {
    final cells = defaultTestCells(unlockedCount: 1);
    final initialState = testCellsState(
      cells: cells,
      productionByCellId: testProductionMap(cells, amount: BigNumber(1, 0)),
    );
    harness.init(cellsState: initialState, prestigeState: testPrestigeState());

    await tester.pumpWidget(harness.wrap(const ProductionContent()));
    await tester.pump();

    expect(find.text('1.0'), findsOneWidget);

    harness.setCellsState(withProductionAmount(initialState, cells.first.id, BigNumber(42, 0)));
    await tester.pump();

    expect(find.text('42.0'), findsOneWidget);
  });
}
