import 'package:idle_laboratory/core/enums/story_beat_id.dart';

/// Reads are synchronous: story state is built eagerly from already-loaded prefs.
abstract class StoryLoreRepository {
  bool isBeatSeen(StoryBeatId beat);
  bool isEndingSeen();
  Future<void> saveBeatSeen(StoryBeatId beat);
  Future<void> saveEndingSeen();
  Future<void> clearBeat(StoryBeatId beat);
  Future<void> clearEndingSeen();
}
