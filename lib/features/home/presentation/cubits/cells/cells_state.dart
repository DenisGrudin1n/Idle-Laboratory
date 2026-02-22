part of 'cells_cubit.dart';

@freezed
abstract class CellsState with _$CellsState {
  const factory CellsState({
    @Default(<CellModel>[]) List<CellModel> cells,
    BigNumber? totalEnergy,
    String? selectedCellId,
  }) = _CellsState;
}
