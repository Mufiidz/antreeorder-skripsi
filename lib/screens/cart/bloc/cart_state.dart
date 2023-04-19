part of 'cart_bloc.dart';

class CartState extends BaseState<List<Order>> {
  const CartState(super.data, {super.status = StatusState.loading});

  CartState copyWith({
    List<Order>? orders,
    StatusState? status,
  }) {
    return CartState(orders ?? data, status: status ?? this.status);
  }

  @override
  String toString() => 'CartState(orders: $data)';
}
