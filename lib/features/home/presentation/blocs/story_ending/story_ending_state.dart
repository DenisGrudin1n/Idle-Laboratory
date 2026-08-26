part of 'story_ending_bloc.dart';

@freezed
abstract class StoryEndingState with _$StoryEndingState {
  const factory StoryEndingState({
    required bool hasSeenEnding,
    @Default(false) bool isPlaying,
    @Default(false) bool pendingPlay,
  }) = _StoryEndingState;

  factory StoryEndingState.initial({required bool hasSeenEnding}) =>
      StoryEndingState(hasSeenEnding: hasSeenEnding);
}
