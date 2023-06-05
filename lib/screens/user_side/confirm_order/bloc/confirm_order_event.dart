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
  final Merchant merchant;

  const AddAntree(this.antree, this.merchant);

  @override
  List<Object?> get props => [antree, merchant];
}

class SelectedSeat extends ConfirmOrderEvent {
  final Seat seat;

  SelectedSeat(this.seat);
  @override
  List<Object?> get props => [seat];
}
