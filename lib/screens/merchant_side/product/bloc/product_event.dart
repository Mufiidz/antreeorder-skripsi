part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class Initial extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class AddProduct extends ProductEvent {
  final Product product;
  final XFile? file;

  const AddProduct(this.product, this.file);

  @override
  List<Object?> get props => [product, file];
}

class MerchantProducts extends ProductEvent {
  final int page;
  const MerchantProducts(this.page);
  @override
  List<Object?> get props => [page];
}

class UpdateProduct extends ProductEvent {
  final Product product;
  final XFile? file;

  const UpdateProduct(
    this.product,
    this.file,
  );

  @override
  List<Object?> get props => [product, file];
}

class DeleteProduct extends ProductEvent {
  final Product product;

  const DeleteProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class AddImage extends ProductEvent {
  final XFile? image;

  AddImage(this.image);
  @override
  List<Object?> get props => [image];
}
