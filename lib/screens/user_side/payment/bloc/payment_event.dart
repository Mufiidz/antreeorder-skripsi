part of 'payment_bloc.dart';

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.successPayment(Antree antree) = _SuccessPayment;
  const factory PaymentEvent.loadingPayment(bool isLoading) = _LoadingPayment;
  const factory PaymentEvent.transactionStatus(String id) =
      _TransactionStatusPayment;
  const factory PaymentEvent.expirePayment(Antree antree) = _ExpirePayment;
}