part of 'merchant_product_bloc.dart';

class MerchantProductState extends BaseState<List<Product>> {
  final Page page;
  final bool isLastPage;
  final List<Product> products;
  final List<Order> orders;
  final int temporaryPrice;
  const MerchantProductState(super.data,
      {super.status = StatusState.loading,
      super.errorMessage = '',
      this.page = const Page(),
      this.isLastPage = false,
      this.products = const [],
      this.orders = const [],
      this.temporaryPrice = 0});

  MerchantProductState copyWith(
      {List<Product>? data,
      StatusState? status,
      String? errorMessage,
      Page? page,
      bool? isLastPage,
      List<Product>? products,
      List<Order>? orders,
      int? temporaryPrice}) {
    return MerchantProductState(data ?? this.data,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        page: page ?? this.page,
        isLastPage: isLastPage ?? this.isLastPage,
        products: products ?? this.products,
        orders: orders ?? this.orders,
        temporaryPrice: temporaryPrice ?? this.temporaryPrice);
  }

  @override
  String toString() {
    return 'MerchantProductState(page: $page, isLastPage: $isLastPage, products: $products, orders: $orders, temporaryPrice: $temporaryPrice, status: $status)';
  }
}
