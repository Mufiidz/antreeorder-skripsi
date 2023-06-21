import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/data/remote/response/token_midtrains_response.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/online_payment.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_apiclient.g.dart';

@RestApi()
abstract class PaymentApiClient {
  factory PaymentApiClient(Dio dio, {String baseUrl}) = _PaymentApiClient;

  static const String transactions = '/transactions';
  static const String payments = '/payments';
  static const String authorization = 'Authorization';

  @POST(transactions)
  Future<TokenMidtrainsResponse> tokenPayment(@Body() BaseBody body,
      {@Header(authorization) required String authorization});

  @POST(payments)
  Future<BaseResponse<OnlinePayment>> addPayment(@Body() BaseBody body);
}
