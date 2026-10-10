import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/story_lore_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalStorageDataSource extends Mock implements LocalStorageDataSource {}

void main() {
  late _MockLocalStorageDataSource dataSource;
  late StoryLoreRepositoryImpl repository;

  setUp(() {
    dataSource = _MockLocalStorageDataSource();
    repository = StoryLoreRepositoryImpl(dataSource);
  });

  test('isBeatSeen returns false when key is absent', () {
    when(() => dataSource.getBool(StorageKeys.storyBeatDarkMatterUnlocked)).thenReturn(null);
    expect(repository.isBeatSeen(StoryBeatId.darkMatterUnlocked), isFalse);
  });

  test('isEndingSeen returns false when key is missing', () {
    when(() => dataSource.getBool(StorageKeys.endingCutsceneSeen)).thenReturn(null);
    expect(repository.isEndingSeen(), isFalse);
  });

  test('saveBeatSeen persists beat flag', () async {
    when(() => dataSource.setBool(StorageKeys.storyBeatFirstBloodDrop, value: true)).thenAnswer((_) async => true);

    await repository.saveBeatSeen(StoryBeatId.firstBloodDrop);

    verify(() => dataSource.setBool(StorageKeys.storyBeatFirstBloodDrop, value: true)).called(1);
  });

  test('saveEndingSeen persists true', () async {
    when(() => dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true)).thenAnswer((_) async => true);

    await repository.saveEndingSeen();

    verify(() => dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true)).called(1);
  });

  test('clearBeat removes beat flag', () async {
    when(() => dataSource.remove(StorageKeys.storyBeatAbyssalHeart)).thenAnswer((_) async => true);

    await repository.clearBeat(StoryBeatId.abyssalHeartCrafted);

    verify(() => dataSource.remove(StorageKeys.storyBeatAbyssalHeart)).called(1);
  });

  test('clearEndingSeen removes the key', () async {
    when(() => dataSource.remove(StorageKeys.endingCutsceneSeen)).thenAnswer((_) async => true);

    await repository.clearEndingSeen();

    verify(() => dataSource.remove(StorageKeys.endingCutsceneSeen)).called(1);
  });
}
