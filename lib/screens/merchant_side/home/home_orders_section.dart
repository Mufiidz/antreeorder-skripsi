import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

class HomeOrdersSection extends StatelessWidget {
  final List<Order> orders;
  const HomeOrdersSection(this.orders, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AntreeList<Order>(
        orders,
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: AntreeColors.separator)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AntreeText(item.title.isNotEmpty ? item.title : '-'),
                  AntreeText('Jumlah : ${item.quantity}')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
