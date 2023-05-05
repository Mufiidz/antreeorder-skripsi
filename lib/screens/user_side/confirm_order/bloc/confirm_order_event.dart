part of 'confirm_order_bloc.dart';

abstract class ConfirmOrderEvent extends Equatable {
  const ConfirmOrderEvent();
}

class GetInitialConfirm extends ConfirmOrderEvent {
  final List<Order> orders;
  final Summary summary;

  const GetInitialConfirm(this.orders, this.summary);

  @override
  List<Object> get props => [orders, summary];
}

class AddAntree extends ConfirmOrderEvent {
  final Antree antree;

  const AddAntree(this.antree);

  @override
  List<Object?> get props => [antree];
}
