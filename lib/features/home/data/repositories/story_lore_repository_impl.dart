import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/core/exceptions/game_exceptions.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/data/repositories/story_lore_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StoryLoreRepository)
class StoryLoreRepositoryImpl implements StoryLoreRepository {
  const StoryLoreRepositoryImpl(this._dataSource);
  final LocalStorageDataSource _dataSource;

  @override
  bool isBeatSeen(StoryBeatId beat) => _dataSource.getBool(_keyFor(beat)) ?? false;

  @override
  bool isEndingSeen() => _dataSource.getBool(StorageKeys.endingCutsceneSeen) ?? false;

  @override
  Future<void> saveBeatSeen(StoryBeatId beat) => guardAsync(() => _dataSource.setBool(_keyFor(beat), value: true));

  @override
  Future<void> saveEndingSeen() => guardAsync(() => _dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true));

  @override
  Future<void> clearBeat(StoryBeatId beat) => guardAsync(() => _dataSource.remove(_keyFor(beat)));

  @override
  Future<void> clearEndingSeen() => guardAsync(() => _dataSource.remove(StorageKeys.endingCutsceneSeen));

  String _keyFor(StoryBeatId beat) => switch (beat) {
        StoryBeatId.darkMatterUnlocked => StorageKeys.storyBeatDarkMatterUnlocked,
        StoryBeatId.darkMatterProductionMaxed => StorageKeys.storyBeatDarkMatterProductionMax,
        StoryBeatId.firstBloodDrop => StorageKeys.storyBeatFirstBloodDrop,
        StoryBeatId.abyssalHeartCrafted => StorageKeys.storyBeatAbyssalHeart,
      };
}
