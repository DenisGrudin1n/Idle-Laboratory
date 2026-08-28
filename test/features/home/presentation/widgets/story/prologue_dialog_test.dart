import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/app_version_enum.dart';
import 'package:idle_laboratory/core/enums/magician_emotion.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/core/theme/app_theme.dart';
import 'package:idle_laboratory/core/widgets/magician_sprite.dart';
import 'package:idle_laboratory/core/widgets/section_card.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:idle_laboratory/features/home/domain/services/story_lore_service.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/app_layout/app_layout_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_lore/story_lore_bloc.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/story/prologue_dialog.dart';
import 'package:idle_laboratory/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class _MockAppLayoutBloc extends Mock implements AppLayoutBloc {}

class _MockStoryLoreService extends Mock implements StoryLoreService {}

class _MockStorageService extends Mock implements StorageService {}

StoryLoreBloc _createStoryLoreBloc() {
  final storyLoreService = _MockStoryLoreService();
  when(() => storyLoreService.isBeatSeen(any())).thenReturn(false);
  when(storyLoreService.isEndingSeen).thenReturn(false);
  return StoryLoreBloc(storyLoreService, _MockStorageService());
}

Widget _wrap(Widget child, AppLayoutBloc layoutBloc, {Size size = const Size(390, 844)}) {
  return BlocProvider<AppLayoutBloc>.value(
    value: layoutBloc,
    child: BlocProvider(
      create: (_) => _createStoryLoreBloc(),
      child: MaterialApp(
        theme: AppTheme.defaultTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        builder: (context, appChild) => MediaQuery(
          data: MediaQuery.of(context).copyWith(size: size),
          child: appChild ?? const SizedBox.shrink(),
        ),
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

  setUpAll(() {
    registerFallbackValue(StoryBeatId.darkMatterUnlocked);
  });

  testWidgets('PrologueDialog shows kind magician and first page copy', (tester) async {
    await tester.pumpWidget(_wrap(const PrologueDialog(), layoutBloc));
    await tester.pump();

    expect(find.text('A New Laboratory'), findsOneWidget);
    expect(find.textContaining('Welcome, apprentice'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);
    expect(find.text('BEGIN'), findsNothing);

    final sprite = tester.widget<MagicianSprite>(find.byType(MagicianSprite));
    expect(sprite.emotion, MagicianEmotion.kind);
  });

  testWidgets('PrologueDialog advances to Bloodstone goal page then closes', (tester) async {
    await tester.pumpWidget(
      BlocProvider<AppLayoutBloc>.value(
        value: layoutBloc,
        child: BlocProvider(
          create: (_) => _createStoryLoreBloc(),
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
                body: TextButton(onPressed: () => PrologueDialog.show(context), child: const Text('open')),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(PrologueDialog), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    expect(find.text('Our Shared Purpose'), findsOneWidget);
    expect(find.textContaining('Bloodstone of Dominion'), findsOneWidget);
    expect(find.text('BEGIN'), findsOneWidget);

    await tester.tap(find.text('BEGIN'));
    await tester.pumpAndSettle();
    expect(find.byType(PrologueDialog), findsNothing);
  });

  testWidgets('PrologueDialog supports horizontal swipe between pages', (tester) async {
    await tester.pumpWidget(_wrap(const PrologueDialog(), layoutBloc));
    await tester.pumpAndSettle();

    expect(find.text('A New Laboratory'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(find.text('Our Shared Purpose'), findsOneWidget);
    expect(find.text('BEGIN'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(400, 0));
    await tester.pumpAndSettle();

    expect(find.text('A New Laboratory'), findsOneWidget);
    expect(find.text('NEXT'), findsOneWidget);
  });

  testWidgets('PrologueDialog uses a mid-wide card on desk landscape', (tester) async {
    when(() => layoutBloc.state).thenReturn(const AppLayoutState.initial(appVersion: AppVersionEnum.desk));
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrap(const PrologueDialog(), layoutBloc, size: const Size(1440, 900)));
    await tester.pump();

    final card = tester.getSize(find.byType(SectionCard));
    expect(card.width, greaterThan(900));
    expect(card.width, lessThan(1100));
    expect(tester.takeException(), isNull);
  });

  testWidgets('PrologueDialog fits landscape without overflow', (tester) async {
    await tester.pumpWidget(_wrap(const PrologueDialog(), layoutBloc, size: const Size(852, 393)));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('NEXT'), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('BEGIN'), findsOneWidget);
  });
}
