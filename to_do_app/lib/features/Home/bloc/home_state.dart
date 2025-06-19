part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState{
  final Tasks tasks;
  HomeLoadedState({required this.tasks});
}

class HomeNavigateToTaskDetailsState extends HomeActionState{
  final String title;
  final String content;
  HomeNavigateToTaskDetailsState({required this.title,required this.content});
}
