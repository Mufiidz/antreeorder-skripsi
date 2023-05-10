import 'package:antreeorder/components/antree_text.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

class MerchantStatusSection extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  const MerchantStatusSection(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AntreeText(
                'Merchant Status',
                style: AntreeTextStyle.medium,
              ),
              AntreeText(
                'Now merchant is ${value ? 'Open' : 'Close'}',
                style: AntreeTextStyle.normal
                    .copyWith(color: Colors.grey, fontSize: 12),
              )
            ],
          )),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: Switch(
                value: value,
                onChanged: onChanged,
                inactiveTrackColor: AntreeColors.separator),
          ))
        ],
      ),
    );
  }
}
