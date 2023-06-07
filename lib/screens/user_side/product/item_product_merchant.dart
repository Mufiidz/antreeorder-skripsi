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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(flex: 1, child: getImageProduct() ?? Container()),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AntreeText(
                    product.title,
                    style: AntreeTextStyle.bold,
                    fontSize: 16,
                    maxLines: 2,
                  ),
                  // const AntreeSpacer(),
                  AntreeText(
                    product.description,
                    maxLines: 2,
                    fontSize: 14,
                    textColor: Colors.grey,
                  ),
                  const AntreeSpacer(
                    size: 8,
                  ),
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

  Widget? getImageProduct() {
    final imgProduct = product.cover?.imageUrl ?? '';
    return imgProduct.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AntreeImage(
              imgProduct,
              fit: BoxFit.cover,
              height: 60,
            ),
          )
        : null;
  }
}
