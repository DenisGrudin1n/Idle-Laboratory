import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/features/home/domain/services/storage_service.dart';
import 'package:idle_laboratory/features/home/domain/services/story_ending_service.dart';
import 'package:injectable/injectable.dart';

part 'story_ending_event.dart';
part 'story_ending_state.dart';
part 'story_ending_bloc.freezed.dart';

@injectable
class StoryEndingBloc extends SafeBloc<StoryEndingEvent, StoryEndingState> {
  StoryEndingBloc(this._storyEndingService, this._storageService)
      : super(
          StoryEndingState.initial(hasSeenEnding: _storyEndingService.hasSeenEnding),
        ) {
    on<_BloodstoneCrafted>(_onBloodstoneCrafted);
    on<_SequenceCompleted>(_onSequenceCompleted);
    on<_DebugReplay>(_onDebugReplay);
  }

  final StoryEndingService _storyEndingService;
  final StorageService _storageService;

  void _onBloodstoneCrafted(_BloodstoneCrafted event, Emitter<StoryEndingState> emit) {
    if (state.hasSeenEnding || state.isPlaying) return;
    emit(state.copyWith(pendingPlay: true, isPlaying: true));
  }

  Future<void> _onSequenceCompleted(
    _SequenceCompleted event,
    Emitter<StoryEndingState> emit,
  ) async {
    await _storyEndingService.markEndingSeen();
    emit(
      state.copyWith(
        hasSeenEnding: true,
        isPlaying: false,
        pendingPlay: false,
      ),
    );
  }

  Future<void> _onDebugReplay(_DebugReplay event, Emitter<StoryEndingState> emit) async {
    if (state.isPlaying) return;
    await _storyEndingService.resetEndingSeen();
    emit(state.copyWith(hasSeenEnding: false, pendingPlay: false, isPlaying: false));
    _storageService.addMaterial(ResearchMaterialId.bloodstoneOfDominion);
  }
}
