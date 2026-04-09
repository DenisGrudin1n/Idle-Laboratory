part of 'navigation_bloc.dart';

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState({
    @Default(MainNavigationTab.cells) MainNavigationTab mainTab,
    @Default(CellsTab.energyCells) CellsTab cellsTab,
    @Default(CraftingTab.crafting) CraftingTab craftingTab,
  }) = _NavigationState;
}
