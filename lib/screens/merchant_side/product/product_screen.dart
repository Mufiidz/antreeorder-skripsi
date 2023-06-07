import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/screens/merchant_side/product/add/add_product_screen.dart';
import 'package:antreeorder/screens/merchant_side/product/item_product.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'bloc/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ProductBloc _productBloc;
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _productBloc = getIt<ProductBloc>();
    _pagingController.addPageRequestListener(
        (pageKey) => _productBloc.add(MerchantProducts(pageKey)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productBloc,
      child: Scaffold(
        appBar: AntreeAppBar('My Product'),
        body: RefreshIndicator(
          onRefresh: () async => _pagingController.refresh(),
          child: BlocListener<ProductBloc, ProductState>(
            bloc: _productBloc,
            listener: (context, state) {
              if (state.status == StatusState.idleList) {
                if (state.isLastPage) {
                  _pagingController.appendLastPage(state.products);
                } else {
                  _pagingController.appendPage(
                      state.products, _pagingController.nextPageKey);
                }
              }
              if (state.status == StatusState.failure) {
                _pagingController.error = state.message;
              }
            },
            child: AntreeList<Product>.paging(
              _pagingController,
              itemBuilder: (context, item, index) => ItemProduct(
                item,
                onDeleteItem: (productId) {
                  _productBloc.add(DeleteProduct(item));
                  _pagingController.refresh();
                },
              ),
            ),
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
