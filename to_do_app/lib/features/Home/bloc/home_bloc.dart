import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/backend/database.dart';
import 'package:to_do_app/models/tasks.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<HomeTaskClickedEvent>(_onHomeTaskClickedEvent);
    on<HomeTaskDeleteClickedEvent>(_onHomeTaskDeleteClickedEvent);
    on<HomeTaskCreateClickedEvent>(_onHomeTaskCreateClickedEvent);
  }

  FutureOr<void> _onHomeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    final db = Database();
    try {
      final result = await db.fetchTasks();
      emit(HomeLoadedState(tasks: result));
    } catch (e) {
      throw (e.toString());
    }
  }

  FutureOr<void> _onHomeTaskClickedEvent(
    HomeTaskClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    final db = Database();
    try {
      final result = await db.fetchTaskDetails(event.title);
      print(result.content.toString());
      emit(HomeNavigateToTaskDetailsState(title: event.title, content: result.content.toString()));
    } catch (e) {
      throw (e.toString());
    }
  }

  FutureOr<void> _onHomeTaskDeleteClickedEvent(
    HomeTaskDeleteClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    final db = Database();
    try {
      final result = await db.deleteTask(event.title);
      add(HomeInitialEvent());
    } catch (e) {
      throw (e.toString());
    }
  }

  FutureOr<void> _onHomeTaskCreateClickedEvent(
    HomeTaskCreateClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    final db = Database();
    try{
      final result = await db.createTask(event.title, event.content);
      add(HomeInitialEvent());
    } catch(e){
      throw(e.toString());
    }
  }
}
