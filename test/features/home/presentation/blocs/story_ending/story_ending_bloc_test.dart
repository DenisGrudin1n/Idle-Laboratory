import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:idle_laboratory/features/home/domain/services/story_ending_service.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_ending/story_ending_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockStoryEndingService extends Mock implements StoryEndingService {}

class _MockStorageService extends Mock implements StorageService {}

void main() {
  late _MockStoryEndingService storyEndingService;
  late _MockStorageService storageService;

  setUp(() {
    storyEndingService = _MockStoryEndingService();
    storageService = _MockStorageService();
    when(() => storyEndingService.hasSeenEnding).thenReturn(false);
    when(() => storyEndingService.markEndingSeen()).thenAnswer((_) async {});
    when(() => storyEndingService.resetEndingSeen()).thenAnswer((_) async {});
  });

  StoryEndingBloc buildBloc() => StoryEndingBloc(storyEndingService, storageService);

  test('bloodstoneCrafted sets pendingPlay when not seen', () {
    final bloc = buildBloc()..add(const StoryEndingEvent.bloodstoneCrafted());

    expectLater(
      bloc.stream,
      emits(
        isA<StoryEndingState>()
            .having((s) => s.pendingPlay, 'pendingPlay', true)
            .having((s) => s.isPlaying, 'isPlaying', true),
      ),
    );
  });

  test('bloodstoneCrafted is ignored when already seen', () async {
    when(() => storyEndingService.hasSeenEnding).thenReturn(true);
    final bloc = buildBloc()..add(const StoryEndingEvent.bloodstoneCrafted());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.pendingPlay, isFalse);
    expect(bloc.state.isPlaying, isFalse);
  });

  test('sequenceCompleted marks ending seen', () async {
    final bloc = buildBloc()..add(const StoryEndingEvent.bloodstoneCrafted());
    await Future<void>.delayed(Duration.zero);
    bloc.add(const StoryEndingEvent.sequenceCompleted());
    await Future<void>.delayed(Duration.zero);

    verify(() => storyEndingService.markEndingSeen()).called(1);
    expect(bloc.state.hasSeenEnding, isTrue);
    expect(bloc.state.pendingPlay, isFalse);
    expect(bloc.state.isPlaying, isFalse);
  });

  test('debugReplay resets flag and crafts bloodstone', () async {
    when(() => storyEndingService.hasSeenEnding).thenReturn(true);
    final bloc = buildBloc()..add(const StoryEndingEvent.debugReplay());
    await Future<void>.delayed(Duration.zero);

    verify(() => storyEndingService.resetEndingSeen()).called(1);
    verify(() => storageService.addMaterial(ResearchMaterialId.bloodstoneOfDominion)).called(1);
    expect(bloc.state.hasSeenEnding, isFalse);
  });
}
