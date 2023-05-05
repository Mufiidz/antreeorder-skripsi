part of 'product_bloc.dart';

class ProductState extends BaseState<Product> {
  final List<Product> products;
  final List<String> categories;
  const ProductState(super.data,
      {super.message,
      super.status,
      this.products = const [],
      this.categories = const []});

  @override
  List<Object> get props =>
      [products, message, data, status, categories];

  ProductState copyWith(
      {Product? data,
      StatusState? status,
      List<Product>? products,
      List<String>? categories,
      String? message}) {
    return ProductState(data ?? this.data,
        status: status ?? this.status,
        products: products ?? this.products,
        message: message ?? this.message,
        categories: categories ?? this.categories);
  }

  @override
  String toString() =>
      'ProductState(status: $status, products: $products, message: $message, data: $data, categories: $categories)';
}
