import 'package:antreeorder/models/group_product.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/order.dart';
import 'package:antreeorder/models/page.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/repository/merchant_repository2.dart';

part 'merchant_product_event.dart';
part 'merchant_product_state.dart';

class MerchantProductBloc
    extends Bloc<MerchantProductEvent, MerchantProductState> {
  final MerchantRepository2 _merchantRepository;
  var products = <Product>[];
  int tempPrice = 0;

  MerchantProductBloc(this._merchantRepository)
      : super(const MerchantProductState([])) {
    on<GetMerchantProductEvent>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        if (event.merchantId.isEmpty) {
          emit(
              state.copyWith(status: StatusState.failure, message: 'Empty Id'));
        }
        final response = await _merchantRepository
            .getMerchantProduct(event.merchantId, page: event.page);
        final data = response.data;
        final page = response.page;
        final products = data ?? [];
        final isLastPage = page?.currentPage == page?.totalPage;
        products.sort(((a, b) => a.category.compareTo(b.category)));
        final groups = groupedList2(products);
        emit(data != null
            ? state.copyWith(
                data: groups,
                status: StatusState.idle,
                page: response.page,
                isLastPage: isLastPage)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "Error"));
      }
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

  List<Product> getDummyData() => List.generate(
      10,
      (index) => Product(
          id: index,
          title: "Product $index",
          price: index * 1000,
          description: "Ini contoh product $index"));

  List<GroupProduct> groupedList2(List<Product> products) {
    List<GroupProduct> newList = [];
    var mapList = groupBy(products, (p0) => p0.category);
    mapList.forEach((key, value) {
      newList.add(GroupProduct(title: key, products: value));
    });
    return newList;
  }
}
