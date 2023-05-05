import 'product.dart';

class GroupProduct {
  final String title;
  final List<Product> products;

  const GroupProduct({this.title = '', this.products = const []});

  @override
  String toString() {
    return 'GroupProduct(title: $title, products: $products)';
  }

  GroupProduct copyWith({
    String? title,
    List<Product>? products,
  }) {
    return GroupProduct(
      title: title ?? this.title,
      products: products ?? this.products,
    );
  }
}
