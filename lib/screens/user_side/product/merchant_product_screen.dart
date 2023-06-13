import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/group_product.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/res/export_res.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/export_components.dart';
import '../cart/cart_screen.dart';
import 'bloc/merchant_product_bloc.dart';
import 'item_group_product.dart';

class MerchantProductScreen extends StatefulWidget {
  final Merchant merchant;
  const MerchantProductScreen({Key? key, required this.merchant})
      : super(key: key);

  @override
  State<MerchantProductScreen> createState() => _MerchantProductScreenState();
}

class _MerchantProductScreenState extends State<MerchantProductScreen> {
  late final MerchantProductBloc _merchantProductBloc;

  final PagingController<int, GroupProduct> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _merchantProductBloc = getIt<MerchantProductBloc>();
    _pagingController.addPageRequestListener((pageKey) => _merchantProductBloc
        .add(GetMerchantProductEvent(widget.merchant, page: pageKey)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _merchantProductBloc,
      child: Scaffold(
        appBar: AntreeAppBar(widget.merchant.user.name),
        body: BlocListener<MerchantProductBloc, MerchantProductState>(
          bloc: _merchantProductBloc,
          listenWhen: ((previous, current) => previous.data != current.data),
          listener: (context, state) {
            var currentPage = state.page.currentPage;
            if (state.status == StatusState.idle) {
              if (state.isLastPage) {
                _pagingController.appendLastPage(state.data);
              } else {
                _pagingController.appendPage(state.data, currentPage++);
              }
            }
            if (state.status == StatusState.failure) {
              _pagingController.error = state.message;
            }
          },
          child: Stack(
            children: [
              PagedListView<int, GroupProduct>.separated(
                padding: const EdgeInsets.only(bottom: 70),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<GroupProduct>(
                  itemBuilder: ((context, item, index) => ItemGroupProduct(item,
                      onItemClick: (product) =>
                          _merchantProductBloc.add(AddOrder(product)))),
                  newPageProgressIndicatorBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  firstPageProgressIndicatorBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  newPageErrorIndicatorBuilder: (context) => Center(
                    child: Text(_pagingController.error.toString()),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => Center(
                    child: Text(_pagingController.error.toString()),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                    child: AntreeText('Empty data'),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  indent: 16,
                  endIndent: 16,
                  color: AntreeColors.separator,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height: 65,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: AntreeState<MerchantProductBloc,
                            MerchantProductState>(
                          _merchantProductBloc,
                          child: (state, context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AntreeText('${state.products.length} Item'),
                                    AntreeText(state.temporaryPrice.toIdr()),
                                  ],
                                ),
                                AntreeButton(
                                  "Order",
                                  height: 40,
                                  isChecked: state.orders.isNotEmpty,
                                  onClick: () {
                                    _merchantProductBloc.add(ResetOrder());
                                    AppRoute.to(CartScreen(
                                      orders: state.orders,
                                      merchant: widget.merchant,
                                    ));
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _merchantProductBloc.add(ResetOrder());
    _pagingController.dispose();
    super.dispose();
  }
}
