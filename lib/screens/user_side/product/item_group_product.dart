import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/group_product.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:flutter/material.dart';

import 'item_product_merchant.dart';

class ItemGroupProduct extends StatelessWidget {
  final GroupProduct groupProduct;
  final void Function(Product product) onItemClick;
  const ItemGroupProduct(this.groupProduct,
      {Key? key, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: AntreeText(
            groupProduct.title,
            style: AntreeTextStyle.title,
            fontSize: 22,
          ),
        ),
        AntreeList(
          groupProduct.products,
          shrinkWrap: true,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, item, index) => ItemProductMerchant(
            item,
            onClick: () => onItemClick(item),
          ),
        )
      ],
    );
  }
}
