import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/product/add_product_screen.dart';
import 'package:antreeorder/screens/merchant_side/product/item_product.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ProductBloc _productBloc;
  late final String merchantId;

  @override
  void initState() {
    super.initState();
    _productBloc = getIt<ProductBloc>();
    final sharedPrefRepo = getIt<SharedPrefsRepository>();
    merchantId = '';
    if (merchantId.isNotEmpty) {
      _productBloc.add(MerchantProducts(merchantId));
    } else {
      _productBloc.add(Initial());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productBloc,
      child: Scaffold(
        appBar: AntreeAppBar('My Product'),
        body: RefreshIndicator(
          onRefresh: () async {
            if (merchantId.isNotEmpty) {
              _productBloc.add(MerchantProducts(merchantId));
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            bloc: _productBloc,
            builder: (context, state) {
              logger.d(state.products);
              if (state.status == StatusState.loading) {
                return const AntreeLoading();
              }
              return AntreeData(state.products.isNotEmpty,
                  child: AntreeList<Product>(state.products,
                      itemBuilder: (context, product, index) => ItemProduct(
                            product,
                            onDeleteItem: (productId) =>
                                _productBloc.add(DeleteProduct(productId)),
                          )));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            AppRoute.to(const AddProductScreen());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
