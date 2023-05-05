part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAntrians extends HomeEvent {
  final String merchantId;

  const GetAntrians(this.merchantId);
  @override
  List<Object?> get props => [merchantId];
}

class GetAntrians2 extends HomeEvent {
  final String merchantId;

  const GetAntrians2(this.merchantId);
  @override
  List<Object?> get props => [merchantId];
}

class UpadateStatusAntree extends HomeEvent {
  final String antreeId;
  final int statusId;

  const UpadateStatusAntree(this.antreeId, this.statusId);
  @override
  List<Object?> get props => [antreeId, statusId];
}
