import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/enums/cell_id.dart';
import 'package:injectable/injectable.dart';

part 'crafting_event.dart';
part 'crafting_state.dart';
part 'crafting_bloc.freezed.dart';

@injectable
class CraftingBloc extends SafeBloc<CraftingEvent, CraftingState> {
  CraftingBloc() : super(const CraftingState()) {
    on<_CellSlotChanged>((event, emit) => emit(state.copyWith(selectedCellId: event.cellId)));
    on<_InputsCleared>((_, emit) => emit(const CraftingState()));
  }
}
