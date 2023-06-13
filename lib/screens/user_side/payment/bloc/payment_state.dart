part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState(
      {@Default(StatusState.idle) StatusState status,
      @Default('') String message,
      @Default(Antree()) Antree antree}) = _PaymentState;
}
