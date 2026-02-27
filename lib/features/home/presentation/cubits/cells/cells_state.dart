part of 'cells_cubit.dart';

@freezed
abstract class CellsState with _$CellsState {
  const factory CellsState({
    @Default(<CellModel>[]) List<CellModel> cells,
    BigNumber? totalEnergy,
    String? selectedCellId,

    /// Per-cell dedicated energy for level progression (separate from totalEnergy)
    @Default(<String, BigNumber>{}) Map<String, BigNumber> cellEnergies,
  }) = _CellsState;
}
