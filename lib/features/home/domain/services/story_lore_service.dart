import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StoryLoreService {
  StoryLoreService(this._dataSource);

  final LocalStorageDataSource _dataSource;

  bool isBeatSeen(StoryBeatId beat) => _dataSource.getBool(_keyFor(beat)) ?? false;

  bool isEndingSeen() => _dataSource.getBool(StorageKeys.endingCutsceneSeen) ?? false;

  Future<void> markSeen(StoryBeatId beat) => _dataSource.setBool(_keyFor(beat), value: true);

  Future<void> markEndingSeen() => _dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true);

  Future<void> resetBeat(StoryBeatId beat) => _dataSource.remove(_keyFor(beat));

  Future<void> resetEndingSeen() => _dataSource.remove(StorageKeys.endingCutsceneSeen);

  String _keyFor(StoryBeatId beat) => switch (beat) {
        StoryBeatId.darkMatterUnlocked => StorageKeys.storyBeatDarkMatterUnlocked,
        StoryBeatId.darkMatterProductionMaxed => StorageKeys.storyBeatDarkMatterProductionMax,
        StoryBeatId.firstBloodDrop => StorageKeys.storyBeatFirstBloodDrop,
        StoryBeatId.abyssalHeartCrafted => StorageKeys.storyBeatAbyssalHeart,
      };
}
