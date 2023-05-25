import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class MerchantRepository {
  Future<ResponseResult<Merchant>> updateStatusMerchant(bool isOpen);
  Future<ResponseResult<Merchant>> detailMerchant({bool isAllDetail});
  Future<ResponseResult<List<Merchant>>> getMerchants();
}

@Injectable(as: MerchantRepository)
class MerchantRepositoryImpl extends MerchantRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;

  @factoryMethod
  MerchantRepositoryImpl(this._apiClient, this._sharedPrefsRepository);

  @override
  Future<ResponseResult<Merchant>> updateStatusMerchant(bool isOpen) async {
    BaseBody updateStatusBody = {"isOpen": isOpen};
    final merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) {
      return ResponseResult<Merchant>.error('Merchant Id is empty');
    }
    return _apiClient.merchant
        .updateMerchant(merchantId, updateStatusBody.wrapWithData)
        .awaitResponse;
  }

  @override
  Future<ResponseResult<Merchant>> detailMerchant(
      {bool isAllDetail = true}) async {
    final merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) {
      return ResponseResult<Merchant>.error('Merchant Id is empty');
    }
    return _apiClient.merchant
        .getMerchant(merchantId, query: isAllDetail ? '*' : '')
        .awaitResponse;
  }

  @override
  Future<ResponseResult<List<Merchant>>> getMerchants() async =>
      await _apiClient.merchant.getMerchants().awaitResponse;
}
