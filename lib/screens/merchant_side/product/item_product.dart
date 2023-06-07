import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/res/antree_textstyle.dart';
import 'package:antreeorder/screens/merchant_side/product/add/add_product_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

typedef OnDeleteItem = void Function(int)?;

class ItemProduct extends StatelessWidget {
  final Product product;
  final OnDeleteItem onDeleteItem;
  const ItemProduct(this.product, {Key? key, this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute.to(AddProductScreen(
        product: product,
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(flex: 2, child: getImageProduct() ?? Container()),
            Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AntreeText(
                        product.title.isNotEmpty ? product.title : 'NO TITLE',
                        maxLines: 2,
                        style: AntreeTextStyle.bold,
                      ),
                      AntreeText(
                        product.description.isNotEmpty
                            ? product.description
                            : '-',
                        maxLines: 2,
                      )
                    ],
                  ),
                )),
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () => onDeleteItem!(product.id),
                  icon: const Icon(Icons.delete)),
            )),
          ],
        ),
      ),
    );
  }

  Widget? getImageProduct() {
    final imgProduct = product.cover?.imageUrl ?? '';
    return imgProduct.isNotEmpty
        ? AntreeImage(
            imgProduct,
            fit: BoxFit.cover,
            height: 50,
          )
        : null;
  }
}
