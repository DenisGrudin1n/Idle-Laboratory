import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'prologue_dialog_state.dart';
part 'prologue_dialog_cubit.freezed.dart';

@injectable
class PrologueDialogCubit extends Cubit<PrologueDialogState> {
  PrologueDialogCubit() : super(const PrologueDialogState());

  static const pageCount = 2;

  bool get isLastPage => state.pageIndex >= pageCount - 1;

  void setPage(int pageIndex) {
    if (pageIndex < 0 || pageIndex >= pageCount || pageIndex == state.pageIndex) return;
    emit(state.copyWith(pageIndex: pageIndex));
  }

  void nextPage() {
    if (isLastPage) return;
    emit(state.copyWith(pageIndex: state.pageIndex + 1));
  }
}
