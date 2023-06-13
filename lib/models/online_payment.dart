import 'package:antreeorder/config/api_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'online_payment.freezed.dart';
part 'online_payment.g.dart';

@freezed
class OnlinePayment with _$OnlinePayment {
  const OnlinePayment._();
  factory OnlinePayment(
      {@Default(0) int id,
      @Default('') String token,
      @Default('') String redirectUrl,
      @Default('') String paymentId,
      bool? isSuccess}) = _OnlinePayment;

  factory OnlinePayment.fromJson(Map<String, dynamic> json) =>
      _$OnlinePaymentFromJson(json);

  BaseBody get toAddPayment => {
      'token': token,
      'redirectUrl': redirectUrl,
      'paymentId': paymentId,
    };
}
