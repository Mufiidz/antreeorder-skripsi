// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'midtrans_payment.freezed.dart';
part 'midtrans_payment.g.dart';

@freezed
class MidtransPayment with _$MidtransPayment {
  const factory MidtransPayment({
    @JsonKey(name: 'transaction_details')
    required TransactionDetails transactionDetails,
    @JsonKey(name: 'credit_card') @Default(CreditCard()) CreditCard creditCard,
    @JsonKey(name: 'item_details') required List<ItemDetail> itemDetails,
  }) = _MidtransPayment;

  factory MidtransPayment.fromJson(Map<String, dynamic> json) =>
      _$MidtransPaymentFromJson(json);
}

@freezed
class CreditCard with _$CreditCard {
  const factory CreditCard({
    @Default(true) bool secure,
  }) = _CreditCard;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
}

@freezed
class ItemDetail with _$ItemDetail {
  const factory ItemDetail({
    @Default('') String id,
    @Default(0) int price,
    @Default(0) int quantity,
    @Default('') String name,
  }) = _ItemDetail;

  factory ItemDetail.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailFromJson(json);
}

@freezed
class TransactionDetails with _$TransactionDetails {
  const factory TransactionDetails({
    @JsonKey(name: 'order_id') @Default('') String orderId,
    @JsonKey(name: 'gross_amount') @Default(0) int grossAmount,
  }) = _TransactionDetails;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);
}
