part of 'story_ending_bloc.dart';

@freezed
class StoryEndingEvent with _$StoryEndingEvent {
  const factory StoryEndingEvent.bloodstoneCrafted() = _BloodstoneCrafted;
  const factory StoryEndingEvent.sequenceCompleted() = _SequenceCompleted;
  const factory StoryEndingEvent.debugReplay() = _DebugReplay;
}
