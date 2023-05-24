import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/status_antree.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class AntreeRepository {
  Future<ResponseResult<List<Antree>>> getMerchantAntrees();
  Future<ResponseResult<List<Antree>>> getCustomerAntrees();
  Future<ResponseResult<List<StatusAntree>>> getStatusAntree();
  Future<ResponseResult<Antree>> updateStatusAntree(Antree antree);
}

@Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;
  final AntreeDatabase _antreeDatabase;

  @factoryMethod
  AntreeRepositoryImpl(
      this._apiClient, this._sharedPrefsRepository, this._antreeDatabase);

  @override
  Future<ResponseResult<List<Antree>>> getCustomerAntrees() async {
    final int customerId = _sharedPrefsRepository.user.customerId;
    if (customerId == 0) return ResponseResult.error('Customer Id is empty');
    return _apiClient.antree.getCustomerAntrees(customerId).awaitResponse;
  }

  @override
  Future<ResponseResult<List<Antree>>> getMerchantAntrees() async {
    final int merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    return _apiClient.antree.getMerchantAntrees(merchantId).awaitResponse;
  }

  @override
  Future<ResponseResult<Antree>> updateStatusAntree(Antree antree) async {
    if (antree.id == 0) return ResponseResult.error('Antree Id is empty');
    return _apiClient.antree
        .updateAntree(antree.id, antree.toUpdateStatus.wrapWithData)
        .awaitResponse;
  }

  @override
  Future<ResponseResult<List<StatusAntree>>> getStatusAntree() async {
    List<StatusAntree> statusAntree =
        await _antreeDatabase.statusAntreeDao.statusesAntree();
    if (statusAntree.isNotEmpty) return ResponseResult.data(statusAntree, null);
    ResponseResult<List<StatusAntree>> response =
        await _apiClient.antree.getStatuses().awaitResponse;
    response = response.when(
      data: (data, meta) {
        data.forEach((element) =>
            _antreeDatabase.statusAntreeDao.addStatusAntree(element));
        return ResponseResult.data(data, meta);
      },
      error: (message) => ResponseResult.error(message),
    );
    return response;
  }
}
