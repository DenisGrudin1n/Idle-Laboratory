import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/data/repositories/story_lore_repository.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:idle_laboratory/features/home/domain/services/story_lore_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockStoryLoreRepository extends Mock implements StoryLoreRepository {}

class _MockStorageService extends Mock implements StorageService {}

void main() {
  late _MockStoryLoreRepository repository;
  late _MockStorageService storageService;
  late StoryLoreService service;

  setUpAll(() {
    registerFallbackValue(StoryBeatId.darkMatterUnlocked);
  });

  setUp(() {
    repository = _MockStoryLoreRepository();
    storageService = _MockStorageService();
    service = StoryLoreService(repository, storageService);
  });

  test('isBeatSeen delegates to repository', () {
    when(() => repository.isBeatSeen(StoryBeatId.darkMatterUnlocked)).thenReturn(true);
    expect(service.isBeatSeen(StoryBeatId.darkMatterUnlocked), isTrue);
  });

  test('markSeen persists beat flag', () async {
    when(() => repository.saveBeatSeen(any())).thenAnswer((_) async {});

    await service.markSeen(StoryBeatId.firstBloodDrop);

    verify(() => repository.saveBeatSeen(StoryBeatId.firstBloodDrop)).called(1);
  });

  test('resetBeat clears beat flag', () async {
    when(() => repository.clearBeat(any())).thenAnswer((_) async {});

    await service.resetBeat(StoryBeatId.abyssalHeartCrafted);

    verify(() => repository.clearBeat(StoryBeatId.abyssalHeartCrafted)).called(1);
  });

  test('debugReplayEnding resets ending flag and grants bloodstone', () async {
    when(() => repository.clearEndingSeen()).thenAnswer((_) async {});

    await service.debugReplayEnding();

    verify(() => repository.clearEndingSeen()).called(1);
    verify(() => storageService.addMaterial(ResearchMaterialId.bloodstoneOfDominion)).called(1);
  });
}
