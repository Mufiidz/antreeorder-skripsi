import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/screens/merchant_side/product/add_product_screen.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

typedef OnDeleteItem = void Function(String)?;

class ItemProduct extends StatelessWidget {
  final Product product;
  final OnDeleteItem? onDeleteItem;
  const ItemProduct(this.product, {Key? key, this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(product.description),
      onTap: () => AppRoute.to(AddProductScreen(
        product: product,
      )),
      trailing: IconButton(
          onPressed: () => onDeleteItem!(product.id), icon: const Icon(Icons.delete)),
    );
  }
}
