import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/domain/services/story_lore_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalStorageDataSource extends Mock implements LocalStorageDataSource {}

void main() {
  late _MockLocalStorageDataSource dataSource;
  late StoryLoreService service;

  setUp(() {
    dataSource = _MockLocalStorageDataSource();
    service = StoryLoreService(dataSource);
  });

  test('isBeatSeen returns false when key is absent', () {
    when(() => dataSource.getBool(StorageKeys.storyBeatDarkMatterUnlocked)).thenReturn(null);
    expect(service.isBeatSeen(StoryBeatId.darkMatterUnlocked), isFalse);
  });

  test('isEndingSeen returns false when key is missing', () {
    when(() => dataSource.getBool(StorageKeys.endingCutsceneSeen)).thenReturn(null);
    expect(service.isEndingSeen(), isFalse);
  });

  test('markSeen persists beat flag', () async {
    when(() => dataSource.setBool(StorageKeys.storyBeatFirstBloodDrop, value: true))
        .thenAnswer((_) async => true);

    await service.markSeen(StoryBeatId.firstBloodDrop);

    verify(() => dataSource.setBool(StorageKeys.storyBeatFirstBloodDrop, value: true)).called(1);
  });

  test('markEndingSeen persists true', () async {
    when(() => dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true))
        .thenAnswer((_) async => true);

    await service.markEndingSeen();

    verify(() => dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true)).called(1);
  });

  test('resetBeat removes beat flag', () async {
    when(() => dataSource.remove(StorageKeys.storyBeatAbyssalHeart)).thenAnswer((_) async => true);

    await service.resetBeat(StoryBeatId.abyssalHeartCrafted);

    verify(() => dataSource.remove(StorageKeys.storyBeatAbyssalHeart)).called(1);
  });

  test('resetEndingSeen removes the key', () async {
    when(() => dataSource.remove(StorageKeys.endingCutsceneSeen)).thenAnswer((_) async => true);

    await service.resetEndingSeen();

    verify(() => dataSource.remove(StorageKeys.endingCutsceneSeen)).called(1);
  });
}
