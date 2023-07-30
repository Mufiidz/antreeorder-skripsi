// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'status_antree.dart';

part 'transaction_status.freezed.dart';
part 'transaction_status.g.dart';

@freezed
class TransactionStatus with _$TransactionStatus {
  const TransactionStatus._();
  const factory TransactionStatus({
    @JsonKey(name: "transaction_time") DateTime? transactionTime,
    @JsonKey(name: "gross_amount") @Default("") String grossAmount,
    @JsonKey(name: "currency") @Default("") String currency,
    @JsonKey(name: "order_id") @Default("") String orderId,
    @JsonKey(name: "payment_type") @Default("") String paymentType,
    @JsonKey(name: "signature_key") @Default("") String signatureKey,
    @JsonKey(name: "status_code") @Default("") String statusCode,
    @JsonKey(name: "transaction_id") @Default("") String transactionId,
    @JsonKey(name: "transaction_status") @Default("") String transactionStatus,
    @JsonKey(name: "fraud_status") @Default("") String fraudStatus,
    @JsonKey(name: "expiry_time") DateTime? expiryTime,
    @JsonKey(name: "settlement_time") DateTime? settlementTime,
    @JsonKey(name: "status_message") @Default("") String statusMessage,
    @JsonKey(name: "merchant_id") @Default("") String merchantId,
    @JsonKey(name: "shopeepay_reference_number")
    @Default("")
    String shopeepayReferenceNumber,
    @JsonKey(name: "reference_id") @Default("") String referenceId,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusFromJson(json);

  StatusAntree toPaymentStatusState() => switch (statusCode) {
        "407" => StatusAntree(id: 11, message: "Pembayaran Kadaluarsa"),
        _ => StatusAntree(id: 8, message: "Menunggu Pembayaran")
      };
}
