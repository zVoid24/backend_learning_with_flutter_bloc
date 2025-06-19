part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class HomeTaskClickedEvent extends HomeEvent{
  final String title;
  HomeTaskClickedEvent({required this.title});
}

class HomeTaskDeleteClickedEvent extends HomeEvent{
  final String title;
  HomeTaskDeleteClickedEvent({required this.title});
}

class HomeTaskCreateClickedEvent extends HomeEvent{
  final String title;
  final String content;
  HomeTaskCreateClickedEvent({required this.title,required this.content});
}


