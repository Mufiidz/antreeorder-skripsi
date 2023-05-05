part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class InitCart extends CartEvent {
  final List<Order> orders;

  const InitCart(this.orders);

  @override
  List<Object?> get props => [orders];
}

class ItemQuantity extends CartEvent {
  final Order order;
  final bool isIncreaseQuantity;

  const ItemQuantity(this.order, this.isIncreaseQuantity);
  @override
  List<Object?> get props => [order, isIncreaseQuantity];
}

class DeleteItemCart extends CartEvent {
  final Order order;

  const DeleteItemCart(this.order);

  @override
  List<Object?> get props => [order];
}
