import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/ending_apocalypse_overlay.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/ending_reveal_dialog.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/to_be_continued_screen.dart';
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

  testWidgets('EndingRevealDialog shows evil magician and reveal copy', (tester) async {
    await tester.pumpWidget(_wrap(const EndingRevealDialog(), layoutBloc));
    await tester.pump();

    expect(find.text('The Mask Falls'), findsOneWidget);
    expect(find.textContaining('Bloodstone of Dominion is mine'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);

    final sprite = tester.widget<MagicianSprite>(find.byType(MagicianSprite));
    expect(sprite.emotion, MagicianEmotion.evil);
  });

  testWidgets('EndingRevealDialog fits landscape without overflow', (tester) async {
    await tester.pumpWidget(_wrap(const EndingRevealDialog(), layoutBloc, size: const Size(852, 393)));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(find.textContaining('Bloodstone of Dominion is mine'), findsOneWidget);
  });

  testWidgets('EndingRevealDialog CONTINUE pops the route', (tester) async {
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
              body: TextButton(onPressed: () => EndingRevealDialog.show(context), child: const Text('open')),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(EndingRevealDialog), findsOneWidget);

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    expect(find.byType(EndingRevealDialog), findsNothing);
  });

  testWidgets('EndingApocalypseOverlay reaches black and stays until popped', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.defaultTheme,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                await EndingApocalypseOverlay.play(
                  context,
                  flareDuration: const Duration(milliseconds: 40),
                  flashDuration: const Duration(milliseconds: 20),
                  darkDuration: const Duration(milliseconds: 30),
                );
              },
              child: const Text('play'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('play'));
    await tester.pump();
    expect(find.byType(EndingApocalypseOverlay), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 30));
    await tester.pump(const Duration(milliseconds: 40));
    await tester.pump(const Duration(milliseconds: 300));

    // Still on stack (black hold) until caller pops.
    expect(find.byType(EndingApocalypseOverlay), findsOneWidget);

    tester.state<NavigatorState>(find.byType(Navigator).first).pop();
    await tester.pumpAndSettle();
    expect(find.byType(EndingApocalypseOverlay), findsNothing);
  });

  testWidgets('ToBeContinuedScreen shows epilogue copy', (tester) async {
    await tester.pumpWidget(_wrap(const ToBeContinuedScreen(), layoutBloc));
    await tester.pump();

    expect(find.text('To Be Continued'), findsOneWidget);
    expect(find.textContaining('another time'), findsOneWidget);
    expect(find.text('CLOSE'), findsOneWidget);
  });

  testWidgets('ToBeContinuedScreen fits landscape without overflow', (tester) async {
    await tester.pumpWidget(_wrap(const ToBeContinuedScreen(), layoutBloc, size: const Size(852, 393)));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('CLOSE'), findsOneWidget);
  });
}
