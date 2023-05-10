import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/user_side/confirm_order/components/item_order_section.dart';
import 'package:flutter/material.dart';

class DetailProductsSection extends StatelessWidget {
  final List<Order> orders;
  const DetailProductsSection(this.orders, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AntreeText("Pesanan",
                    style: AntreeTextStyle.medium.bold, fontSize: 18),
                const AntreeSpacer(),
                AntreeList<Order>(
                  orders,
                  shrinkWrap: true,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, item, index) => ItemOrderSection(
                    order: item,
                  ),
                )
              ],
            ),
          );
  }
}
