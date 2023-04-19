import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:antreeorder/screens/cart/item_cart.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order.dart';
import '../confirm_order/confirm_order_screen.dart';
import 'bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  final List<Order> orders;
  const CartScreen({Key? key, required this.orders}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc _cartBloc;

  @override
  void initState() {
    _cartBloc = getIt<CartBloc>();
    _cartBloc.add(InitCart(widget.orders));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cartBloc,
      child: Scaffold(
        appBar: AntreeAppBar("My Orders"),
        body: AntreeState<CartBloc, CartState>(
          _cartBloc,
          child: (state, context) => Column(
            children: [
              Expanded(
                  flex: 2,
                  child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 10),
                      itemBuilder: (context, index) {
                        return ItemCart(
                          state.data[index],
                          onDeleteItem: (order) =>
                              _cartBloc.add(DeleteItemCart(order)),
                          onAddQuantity: (order) =>
                              _cartBloc.add(ItemQuantity(order, true)),
                          onReduceQuantity: (order) =>
                              _cartBloc.add(ItemQuantity(order, false)),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(color: AntreeColors.separator),
                      itemCount: state.data.length)),
              Container(
                width: context.mediaSize.width,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, -2))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: AntreeButton(
                    "Next",
                    isChecked: state.data.isNotEmpty,
                    onclick: () => AppRoute.to(ConfirmOrderScreen(
                      orders: state.data,
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
