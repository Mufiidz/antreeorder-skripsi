import 'package:antreeorder/models/order.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/base_state.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Order> orders = [];
  CartBloc() : super(const CartState([])) {
    on<InitCart>((event, emit) {
      emit(state.copyWith(status: StatusState.loading));
      orders = event.orders;
      emit(state.copyWith(orders: orders, status: StatusState.success));
    });

    on<ItemQuantity>((event, emit) {
      emit(state.copyWith(status: StatusState.loading));
      final newOrders = state.data.map((e) {
        if (e == event.order && (e.quantity >= 1 && e.quantity <= 100)) {
          e.copyWith(
              quantity: event.isIncreaseQuantity ? e.quantity++ : e.quantity--);
        }
        return e;
      }).toList();
      emit(state.copyWith(orders: newOrders, status: StatusState.success));
    });

    on<DeleteItemCart>((event, emit) {
      emit(state.copyWith(status: StatusState.loading));
      state.data.remove(event.order);
      emit(state.copyWith(orders: state.data, status: StatusState.success));
    });
  }
}
