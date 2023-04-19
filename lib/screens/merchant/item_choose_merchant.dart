import 'package:flutter/material.dart';

import 'package:antreeorder/components/antree_text.dart';

import '../../models/merchant.dart';
import '../../res/export_res.dart';

class ItemChooseMerchant extends StatelessWidget {
  final Merchant merchant;
  final Function()? onclick;
  const ItemChooseMerchant({Key? key, required this.merchant, this.onclick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 10,
      surfaceTintColor: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onclick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AntreeText(
                merchant.name,
                style: AntreeTextStyle.medium,
              ),
              const Icon(
                Icons.chevron_right,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
