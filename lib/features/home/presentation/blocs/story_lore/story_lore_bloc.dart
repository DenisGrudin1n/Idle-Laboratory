import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/constants/story_constants.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/core/enums/story_beat_id.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:idle_laboratory/features/home/domain/services/story_lore_service.dart';
import 'package:injectable/injectable.dart';

part 'story_lore_event.dart';
part 'story_lore_state.dart';
part 'story_lore_bloc.freezed.dart';

@injectable
class StoryLoreBloc extends SafeBloc<StoryLoreEvent, StoryLoreState> {
  StoryLoreBloc(this._storyLoreService, this._storageService) : super(StoryLoreState.initial(_storyLoreService)) {
    on<_DarkMatterUnlocked>((event, emit) => _tryQueueBeat(StoryBeatId.darkMatterUnlocked, emit));
    on<_DarkMatterProductionMaxed>((event, emit) => _tryQueueBeat(StoryBeatId.darkMatterProductionMaxed, emit));
    on<_BloodDropCrafted>((event, emit) => _tryQueueBeat(StoryBeatId.firstBloodDrop, emit));
    on<_AbyssalHeartCrafted>((event, emit) => _tryQueueBeat(StoryBeatId.abyssalHeartCrafted, emit));
    on<_BeatDismissed>(_onBeatDismissed);
    on<_DebugShow>(_onDebugShow);
    on<_BloodstoneCrafted>(_onBloodstoneCrafted);
    on<_EndingSequenceCompleted>(_onEndingSequenceCompleted);
    on<_DebugReplayEnding>(_onDebugReplayEnding);
    on<_ProloguePageChanged>(_onProloguePageChanged);
    on<_PrologueNextPage>(_onPrologueNextPage);
    on<_PrologueReset>((event, emit) => emit(state.copyWith(prologuePageIndex: 0)));
  }

  final StoryLoreService _storyLoreService;
  final StorageService _storageService;

  void _tryQueueBeat(StoryBeatId beat, Emitter<StoryLoreState> emit) {
    if (state.pendingBeat != null) return;
    if (state.seenBeats[beat] ?? false) return;
    emit(state.copyWith(pendingBeat: beat));
  }

  Future<void> _onBeatDismissed(_BeatDismissed event, Emitter<StoryLoreState> emit) async {
    final beat = state.pendingBeat;
    if (beat == null) return;

    await _storyLoreService.markSeen(beat);
    emit(state.copyWith(pendingBeat: null, seenBeats: {...state.seenBeats, beat: true}));
  }

  Future<void> _onDebugShow(_DebugShow event, Emitter<StoryLoreState> emit) async {
    await _storyLoreService.resetBeat(event.beat);
    emit(state.copyWith(pendingBeat: event.beat, seenBeats: {...state.seenBeats, event.beat: false}));
  }

  void _onBloodstoneCrafted(_BloodstoneCrafted event, Emitter<StoryLoreState> emit) {
    if (state.hasSeenEnding || state.isEndingPlaying) return;
    emit(state.copyWith(pendingEndingPlay: true, isEndingPlaying: true));
  }

  Future<void> _onEndingSequenceCompleted(_EndingSequenceCompleted event, Emitter<StoryLoreState> emit) async {
    await _storyLoreService.markEndingSeen();
    emit(state.copyWith(hasSeenEnding: true, isEndingPlaying: false, pendingEndingPlay: false));
  }

  Future<void> _onDebugReplayEnding(_DebugReplayEnding event, Emitter<StoryLoreState> emit) async {
    if (state.isEndingPlaying) return;
    await _storyLoreService.resetEndingSeen();
    emit(state.copyWith(hasSeenEnding: false, pendingEndingPlay: false, isEndingPlaying: false));
    _storageService.addMaterial(ResearchMaterialId.bloodstoneOfDominion);
  }

  void _onProloguePageChanged(_ProloguePageChanged event, Emitter<StoryLoreState> emit) {
    final pageIndex = event.pageIndex;
    if (pageIndex < 0 || pageIndex >= StoryConstants.prologuePageCount) return;
    if (pageIndex == state.prologuePageIndex) return;
    emit(state.copyWith(prologuePageIndex: pageIndex));
  }

  void _onPrologueNextPage(_PrologueNextPage event, Emitter<StoryLoreState> emit) {
    if (state.isPrologueLastPage) return;
    emit(state.copyWith(prologuePageIndex: state.prologuePageIndex + 1));
  }
}
