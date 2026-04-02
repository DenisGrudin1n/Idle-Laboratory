part of 'cells_bloc.dart';

@freezed
abstract class CellsState with _$CellsState {
  const factory CellsState({
    @Default(<CellModel>[]) List<CellModel> cells,
    BigNumber? totalEnergy,
    String? selectedCellId,
    @Default(<String, BigNumber>{}) Map<String, BigNumber> cellEnergies,
    @Default(<String, CellProductionEntry>{}) Map<String, CellProductionEntry> productionByCellId,
  }) = _CellsState;
}
