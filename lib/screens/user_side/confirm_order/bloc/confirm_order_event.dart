part of 'confirm_order_bloc.dart';

abstract class ConfirmOrderEvent extends Equatable {
  const ConfirmOrderEvent();
}

class GetInitialConfirm extends ConfirmOrderEvent {
  final List<Order> orders;
  final int merchantId;

  const GetInitialConfirm(this.orders, this.merchantId);

  @override
  List<Object> get props => [orders, merchantId];
}

class AddAntree extends ConfirmOrderEvent {
  final Antree antree;
  final int merchantId;

  const AddAntree(this.antree, this.merchantId);

  @override
  List<Object?> get props => [antree, merchantId];
}

class SelectedSeat extends ConfirmOrderEvent {
  final Seat seat;

  SelectedSeat(this.seat);
  @override
  List<Object?> get props => [seat];
}
