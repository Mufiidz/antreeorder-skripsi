part of 'merchant_product_bloc.dart';

abstract class MerchantProductEvent extends Equatable {
  const MerchantProductEvent();
}

class GetMerchantProductEvent extends MerchantProductEvent {
  final int merchantId;
  final int page;
  final int size;

  const GetMerchantProductEvent(this.merchantId,
      {this.page = 1, this.size = 10});

  @override
  List<Object> get props => [merchantId, page, size];
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
