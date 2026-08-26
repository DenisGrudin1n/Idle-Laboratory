import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/core/widgets/cell_loop_animation_scope.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/cells/cells_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/prestige/prestige_bloc.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockCellsBloc extends Mock implements CellsBloc {}

class MockAppLayoutBloc extends Mock implements AppLayoutBloc {}

class MockPrestigeBloc extends Mock implements PrestigeBloc {}

class ProductionWidgetTestHarness {
  ProductionWidgetTestHarness({required this.cellsBloc, required this.appLayoutBloc, this.prestigeBloc});

  final MockCellsBloc cellsBloc;
  final MockAppLayoutBloc appLayoutBloc;
  final MockPrestigeBloc? prestigeBloc;

  late CellsState _cellsState;
  late StreamController<CellsState> _cellsController;
  late StreamController<AppLayoutState> _layoutController;
  late StreamController<PrestigeState> _prestigeController;

  void setCellsState(CellsState state) {
    _cellsState = state;
    when(() => cellsBloc.state).thenReturn(_cellsState);
    _cellsController.add(_cellsState);
  }

  void setAppLayout(AppLayoutState state) {
    when(() => appLayoutBloc.state).thenReturn(state);
    _layoutController.add(state);
  }

  void setPrestigeState(PrestigeState state) {
    final bloc = prestigeBloc;
    if (bloc == null) return;
    when(() => bloc.state).thenReturn(state);
    _prestigeController.add(state);
  }

  void init({
    required CellsState cellsState,
    AppLayoutState layoutState = const AppLayoutState.initial(appVersion: AppVersionEnum.mobile),
    PrestigeState? prestigeState,
  }) {
    _cellsState = cellsState;
    _cellsController = StreamController<CellsState>.broadcast();
    _layoutController = StreamController<AppLayoutState>.broadcast();
    _prestigeController = StreamController<PrestigeState>.broadcast();

    when(() => cellsBloc.state).thenAnswer((_) => _cellsState);
    when(() => cellsBloc.stream).thenAnswer((_) => _cellsController.stream);
    when(() => cellsBloc.add(any())).thenReturn(null);

    when(() => appLayoutBloc.state).thenReturn(layoutState);
    when(() => appLayoutBloc.stream).thenAnswer((_) => _layoutController.stream);
    when(() => appLayoutBloc.add(any())).thenReturn(null);

    final prestige = prestigeBloc;
    if (prestige != null) {
      final initialPrestige = prestigeState ?? const PrestigeState();
      when(() => prestige.state).thenReturn(initialPrestige);
      when(() => prestige.stream).thenAnswer((_) => _prestigeController.stream);
      when(() => prestige.add(any())).thenReturn(null);
    }

    _cellsController.add(_cellsState);
    _layoutController.add(layoutState);
    if (prestige != null && prestigeState != null) {
      _prestigeController.add(prestigeState);
    }
  }

  void dispose() {
    unawaited(_cellsController.close());
    unawaited(_layoutController.close());
    unawaited(_prestigeController.close());
  }

  Widget wrap(Widget child, {double height = 640, double width = 900}) {
    final providers = <BlocProvider<dynamic>>[
      BlocProvider<CellsBloc>.value(value: cellsBloc),
      BlocProvider<AppLayoutBloc>.value(value: appLayoutBloc),
    ];
    final prestige = prestigeBloc;
    if (prestige != null) {
      providers.add(BlocProvider<PrestigeBloc>.value(value: prestige));
    }

    return MultiBlocProvider(
      providers: providers,
      child: CellLoopAnimationScope(
        child: MaterialApp(
          theme: AppTheme.defaultTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: Scaffold(
            body: SizedBox(width: width, height: height, child: child),
          ),
        ),
      ),
    );
  }
}
