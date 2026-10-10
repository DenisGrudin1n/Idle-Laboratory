import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/data/repositories/story_lore_repository.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StoryLoreService {
  StoryLoreService(this._repository, this._storageService);

  final StoryLoreRepository _repository;
  final StorageService _storageService;

  bool isBeatSeen(StoryBeatId beat) => _repository.isBeatSeen(beat);

  bool isEndingSeen() => _repository.isEndingSeen();

  Future<void> markSeen(StoryBeatId beat) => _repository.saveBeatSeen(beat);

  Future<void> markEndingSeen() => _repository.saveEndingSeen();

  Future<void> resetBeat(StoryBeatId beat) => _repository.clearBeat(beat);

  Future<void> resetEndingSeen() => _repository.clearEndingSeen();

  /// Debug: clears the ending flag and grants the final material so the
  /// ending cutscene triggers again through the normal crafting path.
  Future<void> debugReplayEnding() async {
    await resetEndingSeen();
    _storageService.addMaterial(ResearchMaterialId.bloodstoneOfDominion);
  }
}
