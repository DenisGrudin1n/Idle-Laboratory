part of 'cell_progression_cubit.dart';

@freezed
abstract class CellProgressionState with _$CellProgressionState {
  const factory CellProgressionState({
    @Default(<CellModel>[]) List<CellModel> cells,
    required BigNumber totalEnergy,
  }) = _CellProgressionState;
}
