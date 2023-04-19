import 'package:antreeorder/components/antree_text.dart';
import 'package:antreeorder/models/order.dart';
import 'package:flutter/material.dart';

import '../../res/export_res.dart';
import 'counter_widget.dart';

typedef ItemCartCallback = void Function(Order order);

class ItemCart extends StatelessWidget {
  final Order order;
  final ItemCartCallback onDeleteItem;
  final ItemCartCallback onAddQuantity;
  final ItemCartCallback onReduceQuantity;
  const ItemCart(this.order,
      {Key? key,
      required this.onDeleteItem,
      required this.onAddQuantity,
      required this.onReduceQuantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AntreeText(
            order.product?.title ?? 'TITLE',
            fontSize: 20,
            style: AntreeTextStyle.medium,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AntreeText(
            order.product?.description ?? 'DESC',
            textColor: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        CounterWidget(
          value: order.quantity,
          onDeleteItem: () => onDeleteItem(order),
          onAddQuantity: () => onAddQuantity(order),
          onReduceQuantity: () => onReduceQuantity(order),
        )
      ],
    );
  }
}


// CounterWidget(
//           (newQuantity) {
//             setState(() {
//               widget.order.quantity = newQuantity;
//             });
//             widget.order.price =
//                 newQuantity * (widget.order.product?.price ?? 0);
//           },
//           productQuantity: widget.order.quantity,
//           onDeleteItem: widget.onDeleteItem!(widget.order),
//         )