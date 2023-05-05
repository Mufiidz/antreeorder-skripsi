part of 'merchant_product_bloc.dart';

abstract class MerchantProductEvent extends Equatable {
  const MerchantProductEvent();
}

class GetMerchantProductEvent extends MerchantProductEvent {
  final String merchantId;
  final int page;

  const GetMerchantProductEvent(this.merchantId, {this.page = 1});

  @override
  List<Object> get props => [merchantId, page];
}

class AddOrder extends MerchantProductEvent {
  final Product product;

  const AddOrder(this.product);

  @override
  List<Object> get props => [product];
}

class ResetOrder extends MerchantProductEvent {
  @override
  List<Object?> get props => [];
}
