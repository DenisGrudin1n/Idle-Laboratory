part of 'prologue_dialog_cubit.dart';

@freezed
abstract class PrologueDialogState with _$PrologueDialogState {
  const factory PrologueDialogState({
    @Default(0) int pageIndex,
  }) = _PrologueDialogState;
}
