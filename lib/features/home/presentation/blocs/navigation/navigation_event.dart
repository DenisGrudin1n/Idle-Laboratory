part of 'navigation_bloc.dart';

@freezed
class NavigationEvent with _$NavigationEvent {
  const factory NavigationEvent.mainTabChanged(MainNavigationTab mainTab) = _MainTabChanged;
  const factory NavigationEvent.cellsTabChanged(CellsTab cellsTab) = _CellsTabChanged;
}
