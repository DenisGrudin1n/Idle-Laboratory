import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeBloc<Event, State> extends Bloc<Event, State> {
  SafeBloc(super.initialState);
  bool get isAlive => !isClosed;

  @override
  void emit(State state) {
    // ignore: invalid_use_of_visible_for_testing_member
    if (!isClosed) super.emit(state);
  }
}
