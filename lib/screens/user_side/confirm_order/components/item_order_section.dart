import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class ItemOrderSection extends StatelessWidget {
  final Order order;
  const ItemOrderSection({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: AntreeText(order.title.isNotEmpty ? order.title : 'TITLE')),
        Expanded(
            child: AntreeText(
          "${order.quantity} x",
          textAlign: TextAlign.center,
        )),
        Expanded(
            flex: 2,
            child: AntreeText(
              (order.quantity * order.price).toIdr(),
              textAlign: TextAlign.right,
            )),
      ],
    );
  }
}
