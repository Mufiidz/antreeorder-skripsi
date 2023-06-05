import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/group_product.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/page.dart';
import 'package:antreeorder/models/product.dart';
import 'package:injectable/injectable.dart' as inject;

part 'merchant_product_event.dart';
part 'merchant_product_state.dart';

@inject.singleton
@inject.injectable
class MerchantProductBloc
    extends Bloc<MerchantProductEvent, MerchantProductState> {
  final ProductRepository _productRepository;
  var products = <Product>[];
  int tempPrice = 0;

  MerchantProductBloc(this._productRepository)
      : super(const MerchantProductState([])) {
    on<GetMerchantProductEvent>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response = await _productRepository.getMerchantProducts(
          merchantId: event.merchant.id, page: event.page);
      final newState = response.when(
        data: (data, meta) {
          final page = meta?.pagination ?? Pagination();
          final isLastPage = page.page == page.pageCount;
          data.sort(((a, b) => a.category.compareTo(b.category)));
          data.map((e) => e.copyWith(merchant: event.merchant));
          return state.copyWith(
              status: StatusState.idle,
              page: meta?.pagination.toPage,
              isLastPage: isLastPage,
              data: groupedList2(data));
        },
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });

    on<AddOrder>((event, emit) {
      emit(state.copyWith(status: StatusState.loading));
      var orders = <Order>[];
      products.add(event.product);
      tempPrice = products.fold(
          0, (previousValue, element) => previousValue + element.price);
      var mapOrders = products.groupListsBy((element) => element.id);
      mapOrders.forEach((key, value) {
        var order = value.first.toOrder();
        order.quantity = value.length;
        orders.add(order);
      });

      emit(state.copyWith(
          status: StatusState.idle,
          orders: orders,
          products: products,
          temporaryPrice: tempPrice));
    });

    on<ResetOrder>((event, emit) {
      emit(state.copyWith(status: StatusState.loading));
      products = [];
      tempPrice = 0;
      emit(state.copyWith(
          products: [],
          temporaryPrice: 0,
          orders: [],
          status: StatusState.idle));
    });
  }

  List<GroupProduct> groupedList2(List<Product> products) {
    List<GroupProduct> newList = [];
    var mapList = groupBy(products, (p0) => p0.category);
    mapList.forEach((key, value) {
      newList.add(GroupProduct(title: key, products: value));
    });
    return newList;
  }
}
