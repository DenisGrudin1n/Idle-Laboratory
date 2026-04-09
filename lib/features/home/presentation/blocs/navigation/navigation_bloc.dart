import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/core/bloc/safe_bloc.dart';
import 'package:idle_laboratory/core/enums/cells_tab.dart';
import 'package:idle_laboratory/core/enums/crafting_tab.dart';
import 'package:idle_laboratory/core/enums/main_navigation_tab.dart';
import 'package:injectable/injectable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';
part 'navigation_bloc.freezed.dart';

@injectable
class NavigationBloc extends SafeBloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<_MainTabChanged>((event, emit) => emit(state.copyWith(mainTab: event.mainTab)));
    on<_CellsTabChanged>((event, emit) => emit(state.copyWith(cellsTab: event.cellsTab)));
    on<_CraftingTabChanged>((event, emit) => emit(state.copyWith(craftingTab: event.craftingTab)));
  }
}
