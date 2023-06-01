import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/screens/merchant_side/product/bloc/product_bloc.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
  @override
  void initState() {
    super.initState();
    _productBloc = getIt<ProductBloc>();
    _dialog = getIt<AntreeLoadingDialog>();
    _productBloc.add(GetCategory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productBloc,
      child: Scaffold(
        appBar: AntreeAppBar(
            widget.product == null ? "Add Product" : "Update Product"),
        body: BlocListener<ProductBloc, ProductState>(
          bloc: _productBloc,
          listener: (context, state) {
            final status = state.status;
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
              if (widget.product == null) {
                _formKey.currentState?.fields.forEach((key, value) {
                  _formKey.currentState?.fields[key]?.reset();
                });
              }
            }
          },
          child: FormBuilder(
            key: _formKey,
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemBuilder: (context, index) => _contents[index],
                separatorBuilder: (context, index) => const AntreeSpacer(
                      size: 20,
                    ),
                itemCount: _contents.length),
          ),
        ),
      ),
    );
  }

  List<Widget> get _contents => [
        AntreeTextField(
          'title',
          label: "Title",
          initialValue: widget.product?.title,
        ),
        AntreeTextField(
          'desc',
          label: 'Description',
          initialValue: widget.product?.description,
        ),
        BlocSelector<ProductBloc, ProductState, List<String>>(
          bloc: _productBloc,
          selector: (state) => state.categories,
          builder: (context, state) {
            return AntreeDropdown(
              'category',
              initialValue: widget.product?.category,
              items: state,
              onValueChange: (p0) {},
            );
          },
        ),
        AntreeTextField(
          'quantity',
          label: 'Quantity',
          initialValue: widget.product?.quantity.toString(),
          keyboardType: TextInputType.number,
        ),
        AntreeTextField(
          'price',
          label: 'Price',
          initialValue: widget.product?.price.toString(),
          keyboardType: TextInputType.number,
        ),
        const AntreeSpacer(),
        AntreeButton(
          widget.product == null ? 'Add' : 'Update',
          onClick: onAddProduct,
        )
      ];

  void onAddProduct() {
    final initialProduct = widget.product;
    final formKeyState = _formKey.currentState;
    if (formKeyState == null) return;
    formKeyState.save();

    var product = Product.fromMap(formKeyState.value);

    _dialog.showLoadingDialog(context);

    if (initialProduct == null) {
      _productBloc.add(AddProduct(product));
    } else {
      product = product.copyWith(id: initialProduct.id);
      _productBloc.add(UpdateProduct(product));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
