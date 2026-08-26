import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/core/constants/storage_keys.dart';
import 'package:idle_laboratory/features/home/data/data_sources/local_storage_data_source.dart';
import 'package:idle_laboratory/features/home/domain/services/story_ending_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalStorageDataSource extends Mock implements LocalStorageDataSource {}

void main() {
  late _MockLocalStorageDataSource dataSource;
  late StoryEndingService service;

  setUp(() {
    dataSource = _MockLocalStorageDataSource();
    service = StoryEndingService(dataSource);
  });

  test('hasSeenEnding is false when key is missing', () {
    when(() => dataSource.getBool(StorageKeys.endingCutsceneSeen)).thenReturn(null);
    expect(service.hasSeenEnding, isFalse);
  });

  test('hasSeenEnding reflects stored value', () {
    when(() => dataSource.getBool(StorageKeys.endingCutsceneSeen)).thenReturn(true);
    expect(service.hasSeenEnding, isTrue);
  });

  test('markEndingSeen persists true', () async {
    when(
      () => dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true),
    ).thenAnswer((_) async => true);

    await service.markEndingSeen();

    verify(() => dataSource.setBool(StorageKeys.endingCutsceneSeen, value: true)).called(1);
  });

  test('resetEndingSeen removes the key', () async {
    when(() => dataSource.remove(StorageKeys.endingCutsceneSeen)).thenAnswer((_) async => true);

    await service.resetEndingSeen();

    verify(() => dataSource.remove(StorageKeys.endingCutsceneSeen)).called(1);
  });
}
