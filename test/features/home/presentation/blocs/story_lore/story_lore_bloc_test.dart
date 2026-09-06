import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/story_constants.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:idle_laboratory/features/home/domain/services/story_lore_service.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_lore/story_lore_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockStoryLoreService extends Mock implements StoryLoreService {}

class _MockStorageService extends Mock implements StorageService {}

void main() {
  late _MockStoryLoreService storyLoreService;
  late _MockStorageService storageService;

  setUpAll(() {
    registerFallbackValue(StoryBeatId.darkMatterUnlocked);
  });

  setUp(() {
    storyLoreService = _MockStoryLoreService();
    storageService = _MockStorageService();
    when(() => storyLoreService.isBeatSeen(any())).thenReturn(false);
    when(() => storyLoreService.isEndingSeen()).thenReturn(false);
    when(() => storyLoreService.markSeen(any())).thenAnswer((_) async {});
    when(() => storyLoreService.markEndingSeen()).thenAnswer((_) async {});
    when(() => storyLoreService.resetBeat(any())).thenAnswer((_) async {});
    when(() => storyLoreService.resetEndingSeen()).thenAnswer((_) async {});
  });

  StoryLoreBloc buildBloc() => StoryLoreBloc(storyLoreService, storageService);

  test('darkMatterUnlocked queues beat when not seen', () {
    final bloc = buildBloc()..add(const StoryLoreEvent.darkMatterUnlocked());

    expectLater(
      bloc.stream,
      emits(
        isA<StoryLoreState>().having(
          (s) => s.pendingBeat,
          'pendingBeat',
          StoryBeatId.darkMatterUnlocked,
        ),
      ),
    );
  });

  test('darkMatterUnlocked is ignored when already seen', () async {
    when(() => storyLoreService.isBeatSeen(StoryBeatId.darkMatterUnlocked)).thenReturn(true);
    final bloc = buildBloc()..add(const StoryLoreEvent.darkMatterUnlocked());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.pendingBeat, isNull);
  });

  test('beatDismissed marks beat seen and clears pending', () async {
    final bloc = buildBloc()..add(const StoryLoreEvent.bloodDropCrafted());
    await Future<void>.delayed(Duration.zero);
    bloc.add(const StoryLoreEvent.beatDismissed());
    await Future<void>.delayed(Duration.zero);

    verify(() => storyLoreService.markSeen(StoryBeatId.firstBloodDrop)).called(1);
    expect(bloc.state.pendingBeat, isNull);
    expect(bloc.state.seenBeats[StoryBeatId.firstBloodDrop], isTrue);
  });

  test('debugShow resets beat and queues dialog', () async {
    when(() => storyLoreService.isBeatSeen(StoryBeatId.abyssalHeartCrafted)).thenReturn(true);
    final bloc = buildBloc()
      ..add(const StoryLoreEvent.debugShow(StoryBeatId.abyssalHeartCrafted));
    await Future<void>.delayed(Duration.zero);

    verify(() => storyLoreService.resetBeat(StoryBeatId.abyssalHeartCrafted)).called(1);
    expect(bloc.state.pendingBeat, StoryBeatId.abyssalHeartCrafted);
    expect(bloc.state.seenBeats[StoryBeatId.abyssalHeartCrafted], isFalse);
  });

  test('bloodstoneCrafted sets pendingEndingPlay when not seen', () {
    final bloc = buildBloc()..add(const StoryLoreEvent.bloodstoneCrafted());

    expectLater(
      bloc.stream,
      emits(
        isA<StoryLoreState>()
            .having((s) => s.pendingEndingPlay, 'pendingEndingPlay', true)
            .having((s) => s.isEndingPlaying, 'isEndingPlaying', true),
      ),
    );
  });

  test('endingSequenceCompleted marks ending seen', () async {
    final bloc = buildBloc()..add(const StoryLoreEvent.bloodstoneCrafted());
    await Future<void>.delayed(Duration.zero);
    bloc.add(const StoryLoreEvent.endingSequenceCompleted());
    await Future<void>.delayed(Duration.zero);

    verify(() => storyLoreService.markEndingSeen()).called(1);
    expect(bloc.state.hasSeenEnding, isTrue);
    expect(bloc.state.pendingEndingPlay, isFalse);
    expect(bloc.state.isEndingPlaying, isFalse);
  });

  test('debugReplayEnding resets flag and crafts bloodstone', () async {
    when(() => storyLoreService.isEndingSeen()).thenReturn(true);
    final bloc = buildBloc()..add(const StoryLoreEvent.debugReplayEnding());
    await Future<void>.delayed(Duration.zero);

    verify(() => storyLoreService.resetEndingSeen()).called(1);
    verify(() => storageService.addMaterial(ResearchMaterialId.bloodstoneOfDominion)).called(1);
    expect(bloc.state.hasSeenEnding, isFalse);
  });

  test('prologueNextPage advances page index', () async {
    final bloc = buildBloc()..add(const StoryLoreEvent.prologueNextPage());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.prologuePageIndex, 1);
    expect(bloc.state.isPrologueLastPage, isTrue);
  });

  test('prologueReset clears page index', () async {
    final bloc = buildBloc()
      ..add(const StoryLoreEvent.prologueNextPage())
      ..add(const StoryLoreEvent.prologueReset());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.prologuePageIndex, 0);
    expect(StoryConstants.prologuePageCount, 2);
  });
}
