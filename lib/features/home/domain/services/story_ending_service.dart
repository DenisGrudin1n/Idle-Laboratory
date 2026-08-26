import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StoryEndingService {
  StoryEndingService(this._dataSource);

  final LocalStorageDataSource _dataSource;

  bool get hasSeenEnding => _dataSource.getBool(StorageKeys.endingCutsceneSeen) ?? false;

  Future<void> markEndingSeen() =>
      _dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true);

  Future<void> resetEndingSeen() => _dataSource.remove(StorageKeys.endingCutsceneSeen);
}
