import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/res/export_res.dart';

class PaymentSection extends StatelessWidget {
  final bool isBayarLangsung;
  final Function(bool isBayarLangsung) paymentType;
  const PaymentSection(
      {Key? key, required this.paymentType, this.isBayarLangsung = false})
      : super(key: key);

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
          FormBuilderDropdown<PaymentTypeItem>(
            name: '',
            initialValue: _paymentTypeValue(isBayarLangsung),
            items: _paymentTypes
                .map((e) => DropdownMenuItem<PaymentTypeItem>(
                    value: e, child: Text(e.title)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                paymentType(value.type == PaymentType.langsung);
              }
            },
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  List<PaymentTypeItem> get _paymentTypes => [
        PaymentTypeItem('Bayar di tempat', PaymentType.onthespot),
        PaymentTypeItem('Bayar langsung', PaymentType.langsung)
      ];

  PaymentTypeItem _paymentTypeValue(bool isBayarLangsung) {
    final type = isBayarLangsung ? PaymentType.langsung : PaymentType.onthespot;
    return _paymentTypes.singleWhere((element) => element.type == type,
        orElse: () => _paymentTypes.first);
  }
}

enum PaymentType { langsung, onthespot }

class PaymentTypeItem {
  final String title;
  final PaymentType type;

  PaymentTypeItem(this.title, this.type);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentTypeItem &&
        other.title == title &&
        other.type == type;
  }
}
