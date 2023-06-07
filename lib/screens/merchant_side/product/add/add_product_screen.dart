import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/res/custom_color.dart';
import 'package:antreeorder/screens/merchant_side/product/bloc/product_bloc.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

import 'section/form_add_product.dart';
import 'section/image_add_product.dart';

class AddProductScreen extends StatefulWidget {
  final Product? product;
  const AddProductScreen({Key? key, this.product}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final ProductBloc _productBloc;
  late final AntreeLoadingDialog _dialog;
  XFile? _file = null;
  late Product? _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _productBloc = getIt<ProductBloc>();
    _dialog = getIt<AntreeLoadingDialog>();
    _productBloc.add(GetCategory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productBloc,
      child: BlocSelector<ProductBloc, ProductState, Product>(
        bloc: _productBloc,
        selector: (state) => state.data,
        builder: (context, state) {
          return Scaffold(
            appBar: AntreeAppBar(
                (_product ?? state).id == 0 ? "Add Product" : "Update Product"),
            body: BlocListener<ProductBloc, ProductState>(
              bloc: _productBloc,
              listener: (context, state) {
                final status = state.status;
                _product = state.data;
                _file = state.file;

                if (status == StatusState.failure) {
                  _dialog.dismiss();
                  context.snackbar.showSnackBar(AntreeSnackbar(
                    state.message,
                    status: SnackbarStatus.error,
                  ));
                }
                if (status == StatusState.success) {
                  _dialog.dismiss();
                  context.snackbar.showSnackBar(AntreeSnackbar(
                    state.message,
                    status: SnackbarStatus.success,
                  ));
                }
              },
              child: AntreeList(
                _contents,
                isSeparated: true,
                itemBuilder: (context, item, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: item,
                ),
                separatorBuilder: (context, item, index) => Divider(
                  thickness: 5,
                  color: AntreeColors.separator,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> get _contents => [
        BlocSelector<ProductBloc, ProductState, List<String>>(
          bloc: _productBloc,
          selector: (state) => state.categories,
          builder: (context, categories) {
            return FormAddProduct(
              formKey: _formKey,
              product: _product,
              categories: categories,
            );
          },
        ),
        BlocSelector<ProductBloc, ProductState, XFile?>(
          bloc: _productBloc,
          selector: (state) => state.file,
          builder: (context, state) {
            logger.d('file => $state');
            return ImageAddProduct(
              file: state,
              imageUrl: _product?.cover?.imageUrl,
              onImagePick: (XFile? file) => _productBloc.add(AddImage(file)),
            );
          },
        ),
        BlocSelector<ProductBloc, ProductState, Product>(
          bloc: _productBloc,
          selector: (state) => state.data,
          builder: (context, state) {
            return AntreeButton(
              (_product ?? state).id == 0 ? 'Add' : 'Update',
              onClick: onAddProduct,
            );
          },
        )
      ];

  void onAddProduct() {
    final formKeyState = _formKey.currentState;
    if (formKeyState == null) return;
    if (_file == null) return;
    if (!formKeyState.validate()) return;
    formKeyState.save();
    var product = Product.fromMap(formKeyState.value);

    _dialog.showLoadingDialog(context);
    final productId = _product?.id ?? 0;
    if (_product == null || productId == 0) {
      _productBloc.add(AddProduct(product, _file));
    } else {
      product = product.copyWith(id: productId);
      _productBloc.add(UpdateProduct(product, _file));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
