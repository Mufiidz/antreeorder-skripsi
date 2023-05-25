import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../confirm_order/confirm_order_screen.dart';
import 'bloc/cart_bloc.dart';
import 'item_cart.dart';

class CartScreen extends StatefulWidget {
  final List<Order> orders;
  final int merchantId;
  const CartScreen({Key? key, required this.orders, required this.merchantId}) : super(key: key);

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
                  child: AntreeList<Order>(
                    state.data,
                    isSeparated: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    itemBuilder: (context, order, index) => ItemCart(
                      order,
                      onDeleteItem: (order) =>
                          _cartBloc.add(DeleteItemCart(order)),
                      onAddQuantity: (order) =>
                          _cartBloc.add(ItemQuantity(order, true)),
                      onReduceQuantity: (order) =>
                          _cartBloc.add(ItemQuantity(order, false)),
                    ),
                    separatorBuilder: (context, order, index) =>
                        const Divider(color: AntreeColors.separator),
                  )),
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
                    onclick: () => onClickNext(state.data),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onClickNext(List<Order> data) {
    if (data.isNotEmpty) {
      AppRoute.to(ConfirmOrderScreen(
        orders: data,
        merchantId: widget.merchantId,
      ));
    }
  }
}
