part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAllData extends HomeEvent {
  const GetAllData();
  @override
  List<Object?> get props => [];
}

class GetAntrians2 extends HomeEvent {
  final String merchantId;

  const GetAntrians2(this.merchantId);
  @override
  List<Object?> get props => [merchantId];
}

class UpadateStatusAntree extends HomeEvent {
  final Antree antree;
  final bool isConfirm;

  const UpadateStatusAntree(this.antree, this.isConfirm);
  @override
  List<Object?> get props => [antree, isConfirm];
}
