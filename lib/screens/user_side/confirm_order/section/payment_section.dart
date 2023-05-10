import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AntreeText("Pilih Pembayaran",
              style: AntreeTextStyle.medium.bold, fontSize: 18),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 10,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              width: context.mediaSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: AntreeText("Bayar di tempat",
                  style: AntreeTextStyle.bold.copyWith(fontSize: 16)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
