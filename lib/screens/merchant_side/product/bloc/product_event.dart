part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class MerchantProducts extends ProductEvent {
  final String merchantId;

  const MerchantProducts(this.merchantId);
  @override
  List<Object?> get props => [merchantId];
}

class UpdateProduct extends ProductEvent {
  final Product product;

  const UpdateProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);
  @override
  List<Object?> get props => [productId];
}

class GetCategory extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class Initial extends ProductEvent {
  @override
  List<Object?> get props => [];
}
