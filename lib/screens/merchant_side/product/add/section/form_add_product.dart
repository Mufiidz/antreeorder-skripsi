import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormAddProduct extends StatelessWidget {
  final Key formKey;
  final Product? product;
  final List<String> categories;
  const FormAddProduct(
      {Key? key,
      required this.formKey,
      this.product,
      this.categories = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: AntreeList(
        _contents,
        isSeparated: true,
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, item, index) => item,
        separatorBuilder: (context, item, index) => const AntreeSpacer(
          size: 20,
        ),
      ),
    );
  }

  List<Widget> get _contents => [
        AntreeTextField(
          'title',
          label: "Title",
          initialValue: product?.title,
        ),
        AntreeTextField(
          'desc',
          label: 'Description',
          initialValue: product?.description,
        ),
        AntreeDropdown(
          'category',
          initialValue: product?.category,
          items: categories,
          onValueChange: (p0) {},
        ),
        AntreeTextField(
          'quantity',
          label: 'Quantity',
          initialValue: product?.quantity.toString(),
          keyboardType: TextInputType.number,
        ),
        AntreeTextField(
          'price',
          label: 'Price',
          initialValue: product?.price.toString(),
          keyboardType: TextInputType.number,
        ),
      ];
}
