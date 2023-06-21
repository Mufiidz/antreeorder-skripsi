part of 'product_bloc.dart';

class ProductState extends BaseState<Product> {
  final List<Product> products;
  final List<String> categories;
  final bool isLastPage;
  final XFile? file;
  const ProductState(super.data,
      {super.message,
      super.status,
      this.products = const [],
      this.categories = const [],
      this.isLastPage = true,
      this.file});

  @override
  List<Object?> get props =>
      [products, message, data, status, categories, isLastPage, file];

  ProductState copyWith(
      {Product? data,
      StatusState? status,
      List<Product>? products,
      List<String>? categories,
      String? message,
      XFile? xfile,
      bool? isLastPage}) {
    return ProductState(data ?? this.data,
        status: status ?? this.status,
        products: products ?? this.products,
        message: message ?? this.message,
        categories: categories ?? this.categories,
        isLastPage: isLastPage ?? this.isLastPage,
        file: xfile);
  }

  @override
  String toString() =>
      'ProductState(status: $status, products: $products, message: $message, data: $data, categories: $categories, isLastPage: $isLastPage, file: $file)';
}
