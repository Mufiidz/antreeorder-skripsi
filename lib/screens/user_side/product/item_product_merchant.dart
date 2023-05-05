import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AntreeText(
                    product.title,
                    style: AntreeTextStyle.medium.bold,
                    fontSize: 18,
                  ),
                  const AntreeSpacer(),
                  Container(
                    width: context.mediaSize.width,
                    padding: const EdgeInsets.only(right: 8),
                    child: AntreeText(
                      product.description,
                      maxLines: 2,
                      fontSize: 16,
                      textColor: Colors.grey,
                    ),
                  ),
                  const AntreeSpacer(),
                  AntreeText(
                    product.price.toIdr(),
                    fontSize: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
