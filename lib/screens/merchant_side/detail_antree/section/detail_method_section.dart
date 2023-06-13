import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/online_payment.dart';
import 'package:flutter/material.dart';

class DetailMethodSection extends StatelessWidget {
  final OnlinePayment? payment;
  const DetailMethodSection({Key? key, this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: AntreeText('Metode Pembayaran')),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: AntreeText(
                payment == null ? 'Bayar ditempat' : 'Online Payment'),
          )),
        ],
      ),
    );
  }
}
