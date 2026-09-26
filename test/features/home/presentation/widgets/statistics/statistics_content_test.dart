import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/core/utils/big_number.dart';
import 'package:idle_laboratory/features/home/domain/models/statistics_model/statistics_model.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/settings/settings_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/statistics/statistics_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/statistics/statistics_content.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class _MockAppLayoutBloc extends Mock implements AppLayoutBloc {}

class _MockStatisticsBloc extends Mock implements StatisticsBloc {}

class _MockSettingsBloc extends Mock implements SettingsBloc {}

void main() {
  late _MockAppLayoutBloc layoutBloc;
  late _MockStatisticsBloc statisticsBloc;
  late _MockSettingsBloc settingsBloc;

  setUp(() {
    layoutBloc = _MockAppLayoutBloc();
    statisticsBloc = _MockStatisticsBloc();
    settingsBloc = _MockSettingsBloc();

    when(() => layoutBloc.state).thenReturn(const AppLayoutState.initial(appVersion: AppVersionEnum.mobile));
    when(() => layoutBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => statisticsBloc.state).thenReturn(
      StatisticsState.initial().copyWith(
        stats: StatisticsModel.initial().copyWith(sessionsStarted: 2),
        currentEnergy: BigNumber(10, 0),
      ),
    );
    when(() => statisticsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => statisticsBloc.add(any())).thenReturn(null);

    when(() => settingsBloc.state).thenReturn(SettingsState.initial());
    when(() => settingsBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  setUpAll(() {
    registerFallbackValue(const StatisticsEvent.start());
  });

  testWidgets('StatisticsContent renders core sections', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(390, 844)),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppLayoutBloc>.value(value: layoutBloc),
            BlocProvider<StatisticsBloc>.value(value: statisticsBloc),
            BlocProvider<SettingsBloc>.value(value: settingsBloc),
          ],
          child: MaterialApp(
            theme: AppTheme.defaultTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
            home: const Scaffold(body: StatisticsContent()),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Time & Sessions'), findsOneWidget);
    expect(find.text('Energy'), findsOneWidget);
    expect(find.text('Cells'), findsOneWidget);
    expect(find.text('Sessions started'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();

    expect(find.text('Production'), findsOneWidget);
    expect(find.text('Crafting & Research'), findsOneWidget);
    expect(find.text('Prestige'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
