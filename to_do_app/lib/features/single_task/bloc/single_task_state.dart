part of 'single_task_bloc.dart';

@immutable
abstract class SingleTaskState {}

class SingleTaskInitial extends SingleTaskState {}

class SingleTaskLoadedState extends SingleTaskState{}
