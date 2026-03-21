part of 'cells_bloc.dart';

@freezed
class CellsEvent with _$CellsEvent {
  const factory CellsEvent.cellsChanged(List<CellModel> cells) = _CellsChanged;
  const factory CellsEvent.cellEnergiesChanged(Map<String, BigNumber> cellEnergies) = _CellEnergiesChanged;
  const factory CellsEvent.totalEnergyChanged(BigNumber energy) = _TotalEnergyChanged;
  const factory CellsEvent.selectCell(String cellId) = _SelectCell;
  const factory CellsEvent.start() = _Start;
}
