import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/constants/game_balance.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:idle_laboratory/core/enums/research_material_id.dart';
import 'package:idle_laboratory/features/home/domain/models/crafting_reaction_model/crafting_reaction_model.dart';
import 'package:idle_laboratory/features/home/domain/services/crafting_service.dart';
import 'package:injectable/injectable.dart';

part 'crafting_event.dart';
part 'crafting_state.dart';
part 'crafting_bloc.freezed.dart';

@injectable
class CraftingBloc extends SafeBloc<CraftingEvent, CraftingState> {
  CraftingBloc(this._craftingService) : super(const CraftingState()) {
    on<_CellSlotChanged>(_onCellSlotChanged);
    on<_Reagent1Changed>(_onReagent1Changed);
    on<_Reagent2Changed>(_onReagent2Changed);
    on<_TargetQuantityChanged>(_onTargetQuantityChanged);
    on<_InputsCleared>((_, emit) => emit(const CraftingState()));
    on<_StartReaction>(_onStartReaction);
    on<_StopReaction>((_, _) => _craftingService.stop());
    on<_Validate>(_onValidate);
    on<_SetWatching>(_onSetWatching);
    on<_ReactionChanged>(_onReactionChanged);

    _reactionSubscription = _craftingService.reaction$.listen(
      (reaction) => add(CraftingEvent.reactionChanged(reaction)),
    );
  }

  final CraftingService _craftingService;

  StreamSubscription<void>? _resourcesSubscription;
  StreamSubscription<CraftingReactionModel>? _reactionSubscription;

  Future<void> _onSetWatching(_SetWatching event, Emitter<CraftingState> emit) async {
    if (event.watching) {
      if (_resourcesSubscription != null) return;
      _resourcesSubscription = _craftingService.resourcesChanged$.listen((_) => add(const CraftingEvent.validate()));
      _revalidate(emit);
      return;
    }
    final subscription = _resourcesSubscription;
    _resourcesSubscription = null;
    await subscription?.cancel();
  }

  void _onValidate(_Validate event, Emitter<CraftingState> emit) => _revalidate(emit);

  void _revalidate(Emitter<CraftingState> emit) {
    if (state.craftingMaterialId == null) return;
    _validateAndEmit(state, emit);
  }

  void _onCellSlotChanged(_CellSlotChanged event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    _validateAndEmit(state.copyWith(selectedCellId: event.cellId, reagent1Id: null, reagent2Id: null), emit);
  }

  void _onReagent1Changed(_Reagent1Changed event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    _validateAndEmit(state.copyWith(reagent1Id: event.materialId, selectedCellId: null), emit);
  }

  void _onReagent2Changed(_Reagent2Changed event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    _validateAndEmit(state.copyWith(reagent2Id: event.materialId, selectedCellId: null), emit);
  }

  void _onTargetQuantityChanged(_TargetQuantityChanged event, Emitter<CraftingState> emit) {
    if (state.isCrafting) return;
    final quantity = event.quantity.clamp(1, GameBalance.craftingMaxTargetQuantity);
    _validateAndEmit(state.copyWith(targetQuantity: quantity), emit);
  }

  void _validateAndEmit(CraftingState next, Emitter<CraftingState> emit) {
    final output = _craftingService.outputFor(
      cellId: next.selectedCellId,
      reagent1Id: next.reagent1Id,
      reagent2Id: next.reagent2Id,
    );
    final error = _craftingService.validate(
      quantity: next.targetQuantity,
      cellId: next.selectedCellId,
      reagent1Id: next.reagent1Id,
      reagent2Id: next.reagent2Id,
    );
    emit(next.copyWith(craftingMaterialId: output, error: error));
  }

  void _onStartReaction(_StartReaction event, Emitter<CraftingState> emit) {
    if (state.isCrafting || state.craftingMaterialId == null || state.error != null) return;
    final started = _craftingService.start(
      quantity: state.targetQuantity,
      cellId: state.selectedCellId,
      reagent1Id: state.reagent1Id,
      reagent2Id: state.reagent2Id,
    );
    if (started) emit(state.copyWith(isCrafting: true, craftingProgress: 0));
  }

  void _onReactionChanged(_ReactionChanged event, Emitter<CraftingState> emit) {
    final reaction = event.reaction;
    if (reaction.isCrafting) {
      emit(
        state.copyWith(
          isCrafting: true,
          craftingProgress: reaction.progress,
          targetQuantity: reaction.remaining,
          craftingMaterialId: reaction.outputId,
          selectedCellId: reaction.cellId,
          reagent1Id: reaction.reagent1Id,
          reagent2Id: reaction.reagent2Id,
        ),
      );
      return;
    }
    if (!state.isCrafting) return;
    if (reaction.remaining <= 0) {
      emit(const CraftingState());
      return;
    }
    _validateAndEmit(
      state.copyWith(isCrafting: false, craftingProgress: 0, targetQuantity: reaction.remaining),
      emit,
    );
  }

  @override
  Future<void> close() async {
    await _resourcesSubscription?.cancel();
    await _reactionSubscription?.cancel();
    return super.close();
  }
}
