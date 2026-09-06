part of 'story_lore_bloc.dart';

@freezed
abstract class StoryLoreState with _$StoryLoreState {
  const factory StoryLoreState({
    @Default(<StoryBeatId, bool>{}) Map<StoryBeatId, bool> seenBeats,
    StoryBeatId? pendingBeat,
    @Default(false) bool hasSeenEnding,
    @Default(false) bool isEndingPlaying,
    @Default(false) bool pendingEndingPlay,
    @Default(0) int prologuePageIndex,
  }) = _StoryLoreState;

  factory StoryLoreState.initial(StoryLoreService service) => StoryLoreState(
    seenBeats: {for (final beat in StoryBeatId.values) beat: service.isBeatSeen(beat)},
    hasSeenEnding: service.isEndingSeen(),
  );
  const StoryLoreState._();

  bool get isPrologueLastPage => prologuePageIndex >= StoryConstants.prologuePageCount - 1;
}
