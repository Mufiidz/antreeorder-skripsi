part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAntrians extends HomeEvent {

  const GetAntrians();

  @override
  List<Object?> get props => [];
}

class Dispose extends HomeEvent {
  @override
  List<Object?> get props => [];
}
