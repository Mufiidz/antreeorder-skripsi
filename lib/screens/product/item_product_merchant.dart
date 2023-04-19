import 'package:antreeorder/components/antree_text.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/utils/int_ext.dart';
import 'package:flutter/material.dart';

import '../../res/export_res.dart';

class ItemProductMerchant extends StatelessWidget {
  final Product product;
  final Function()? onClick;
  const ItemProductMerchant(this.product, {Key? key, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AntreeText(
                  product.title,
                  fontSize: 20,
                  style: AntreeTextStyle.medium,
                ),
                AntreeText(
                  product.description,
                  maxLines: 2,
                  style: AntreeTextStyle.light,
                  textColor: Colors.grey,
                ),
                AntreeText(product.price.toIdr())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
