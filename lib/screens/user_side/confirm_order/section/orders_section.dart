import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/int_ext.dart';
import 'package:flutter/material.dart';

import '../components/item_order_section.dart';

class OrdersSection extends StatelessWidget {
  final List<Order> orders;
  final int subtotal;
  const OrdersSection({Key? key, this.orders = const [], this.subtotal = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
          child: AntreeText("Pesanan Yang Dibeli",
              style: AntreeTextStyle.medium.bold.copyWith(fontSize: 18)),
        ),
        Container(
          color: AntreeColors.separator,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: orders.length,
              itemBuilder: (context, index) => ItemOrderSection(
                    order: orders[index],
                  )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AntreeText("Subtotal"),
              AntreeText(subtotal.toIdr()),
            ],
          ),
        )
      ],
    );
  }
}
