import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'single_task_event.dart';
part 'single_task_state.dart';

class SingleTaskBloc extends Bloc<SingleTaskEvent, SingleTaskState> {
  SingleTaskBloc() : super(SingleTaskInitial()) {
    on<SingleTaskInitialEvent>(_onSingleTaskInitialEvent);
  }

  FutureOr<void> _onSingleTaskInitialEvent(
    SingleTaskInitialEvent event,
    Emitter<SingleTaskState> emit,
  ) {
    emit(SingleTaskLoadedState());
  }
}
