part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAntrians extends HomeEvent {
  final String userId;

  const GetAntrians(this.userId);

  @override
  List<Object?> get props => [userId];
}
