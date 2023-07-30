import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/config/env.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/models/transaction_status.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class PaymentRepository {
  Future<ResponseResult<TransactionStatus>> paymentStatus(String id);
  Future<ResponseResult<Antree>> expirePayment(Antree antree);
}

@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepositoryImpl(this._apiClient);

  @override
  Future<ResponseResult<TransactionStatus>> paymentStatus(String id) async {
    if (id.isEmpty) return ResponseResult.error('Empty Id');
    return _apiClient
        .payment(url: ApiClient.midtransBaseUrlV2)
        .transactionStatus(id, 'Basic ${Env.authServerMidtrains}')
        .awaitResponse;
  }

  @override
  Future<ResponseResult<Antree>> expirePayment(Antree antree) async {
    final antreeId = antree.id;
    if (antreeId == 0) return ResponseResult.error('Empty Id');
    antree = antree.copyWith(
        status: StatusAntree(id: 11, message: "Pembayaran Kadaluarsa"));
    BaseBody queries = {
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };

    return _apiClient.antree
        .updateAntree(antreeId, antree.toUpdateStatus.wrapWithData, queries)
        .awaitResponse;
  }
}
