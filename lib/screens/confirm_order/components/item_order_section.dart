import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/utils/int_ext.dart';
import 'package:flutter/material.dart';

class ItemOrderSection extends StatelessWidget {
  final Order order;
  const ItemOrderSection({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: AntreeText(order.product?.title ?? 'TITLE')),
        Expanded(
            child: AntreeText(
          "${order.quantity} x",
          textAlign: TextAlign.center,
        )),
        Expanded(
            flex: 2,
            child: AntreeText(
              (order.quantity * (order.product?.price ?? 0)).toIdr(),
              textAlign: TextAlign.right,
            )),
      ],
    );
  }
}
