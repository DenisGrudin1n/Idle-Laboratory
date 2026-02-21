part of 'cells_cubit.dart';

@freezed
abstract class CellsState with _$CellsState {
  const factory CellsState({
    @Default(<CellModel>[]) List<CellModel> availableCells,
    String? selectedCellId,
  }) = _CellsState;
}
