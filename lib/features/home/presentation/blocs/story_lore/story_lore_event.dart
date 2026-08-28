part of 'story_lore_bloc.dart';

@freezed
class StoryLoreEvent with _$StoryLoreEvent {
  const factory StoryLoreEvent.darkMatterUnlocked() = _DarkMatterUnlocked;
  const factory StoryLoreEvent.darkMatterProductionMaxed() = _DarkMatterProductionMaxed;
  const factory StoryLoreEvent.bloodDropCrafted() = _BloodDropCrafted;
  const factory StoryLoreEvent.abyssalHeartCrafted() = _AbyssalHeartCrafted;
  const factory StoryLoreEvent.beatDismissed() = _BeatDismissed;
  const factory StoryLoreEvent.debugShow(StoryBeatId beat) = _DebugShow;
  const factory StoryLoreEvent.bloodstoneCrafted() = _BloodstoneCrafted;
  const factory StoryLoreEvent.endingSequenceCompleted() = _EndingSequenceCompleted;
  const factory StoryLoreEvent.debugReplayEnding() = _DebugReplayEnding;
  const factory StoryLoreEvent.prologuePageChanged(int pageIndex) = _ProloguePageChanged;
  const factory StoryLoreEvent.prologueNextPage() = _PrologueNextPage;
  const factory StoryLoreEvent.prologueReset() = _PrologueReset;
}
