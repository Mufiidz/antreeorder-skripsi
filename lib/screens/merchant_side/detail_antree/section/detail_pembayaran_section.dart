import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/summary.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/section/detail_method_section.dart';
import 'package:antreeorder/screens/user_side/confirm_order/section/summary_section.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class DetailPembayaranSection extends StatelessWidget {
  final Antree antree;
  const DetailPembayaranSection({Key? key, required this.antree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d(antree.payment);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AntreeText("Ringkasan",
                style: AntreeTextStyle.medium.bold, fontSize: 18),
          ),
          DetailMethodSection(
            payment: antree.payment,
          ),
          Divider(
            color: AntreeColors.separator,
            thickness: 1,
          ),
          SummarySection(summaries: summaries),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AntreeColors.separator))),
            child: Row(
              children: [
                Expanded(
                    child: AntreeText(
                  'Total',
                  style: AntreeTextStyle.medium,
                )),
                Expanded(
                    child: AntreeText(
                  antree.totalPrice.toIdr(),
                  textAlign: TextAlign.end,
                  style: AntreeTextStyle.medium,
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Summary> get summaries => [
        Summary(title: 'Subtotal pesanan', price: subTotal),
        // Summary(title: 'Biaya layanan', price: 1000)
      ];

  int get subTotal => antree.orders.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity));
}
