import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/story_lore_dialog.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class _MockAppLayoutBloc extends Mock implements AppLayoutBloc {}

Widget _wrap(Widget child, AppLayoutBloc layoutBloc, {Size size = const Size(390, 844)}) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: BlocProvider<AppLayoutBloc>.value(
      value: layoutBloc,
      child: MaterialApp(
        theme: AppTheme.defaultTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: Scaffold(body: child),
      ),
    ),
  );
}

void main() {
  late _MockAppLayoutBloc layoutBloc;

  setUp(() {
    layoutBloc = _MockAppLayoutBloc();
    when(() => layoutBloc.state).thenReturn(const AppLayoutState.initial(appVersion: AppVersionEnum.mobile));
    when(() => layoutBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('StoryLoreDialog shows greedy magician and beat copy', (tester) async {
    await tester.pumpWidget(_wrap(const StoryLoreDialog(beat: StoryBeatId.darkMatterUnlocked), layoutBloc));
    await tester.pump();

    expect(find.text('An Unusual Curiosity'), findsOneWidget);
    expect(find.textContaining('Dark matter'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);

    final sprite = tester.widget<MagicianSprite>(find.byType(MagicianSprite));
    expect(sprite.emotion, MagicianEmotion.greedy);
  });

  testWidgets('StoryLoreDialog fits landscape without overflow', (tester) async {
    await tester.pumpWidget(
      _wrap(const StoryLoreDialog(beat: StoryBeatId.abyssalHeartCrafted), layoutBloc, size: const Size(852, 393)),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('The Depths Answer'), findsOneWidget);
    expect(find.textContaining('Abyssal Heart'), findsOneWidget);
  });

  testWidgets('StoryLoreDialog CONTINUE pops the route', (tester) async {
    await tester.pumpWidget(
      BlocProvider<AppLayoutBloc>.value(
        value: layoutBloc,
        child: MaterialApp(
          theme: AppTheme.defaultTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => StoryLoreDialog.show(context, beat: StoryBeatId.firstBloodDrop),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Crimson Reagent'), findsOneWidget);
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    expect(find.text('Crimson Reagent'), findsNothing);
  });
}
