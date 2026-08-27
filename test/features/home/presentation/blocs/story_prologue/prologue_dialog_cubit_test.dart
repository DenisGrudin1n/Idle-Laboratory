import 'package:flutter_test/flutter_test.dart';
import 'package:idle_laboratory/features/home/presentation/blocs/story_prologue/prologue_dialog_cubit.dart';

void main() {
  test('starts on first page', () {
    final cubit = PrologueDialogCubit();
    expect(cubit.state.pageIndex, 0);
    expect(cubit.isLastPage, isFalse);
  });

  test('setPage and nextPage advance within bounds', () {
    final cubit = PrologueDialogCubit()..nextPage();
    expect(cubit.state.pageIndex, 1);
    expect(cubit.isLastPage, isTrue);

    cubit.nextPage();
    expect(cubit.state.pageIndex, 1);

    cubit.setPage(0);
    expect(cubit.state.pageIndex, 0);

    cubit
      ..setPage(-1)
      ..setPage(99);
    expect(cubit.state.pageIndex, 0);
  });
}
