import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idle_laboratory/features/home/data/repositories/cell_repository.dart';
import 'package:idle_laboratory/features/home/domain/models/cell_model.dart';

part 'cells_cubit.freezed.dart';
part 'cells_state.dart';

class CellsCubit extends Cubit<CellsState> {
  CellsCubit(this._cellRepository) : super(const CellsState()) {
    _loadCells();
  }

  final CellRepository _cellRepository;

  void _loadCells() {
    final List<CellModel> cells = _cellRepository.getAvailableCells();
    emit(
      state.copyWith(
        availableCells: cells,
        selectedCellId: cells.isNotEmpty ? cells.first.id : null,
      ),
    );
  }

  void selectCell(String cellId) {
    emit(state.copyWith(selectedCellId: cellId));
  }
}
