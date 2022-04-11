part of 'home_bloc.dart';

abstract class HomeEvent extends HomeState {
  const HomeEvent();
}

class LoadApiEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class NoInternetEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}