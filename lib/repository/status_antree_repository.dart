import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

abstract class StatusAntreeRepository {
  Future<ResponseResult<Antree>> updateStatusAntree(Antree antree);
  Future<ResponseResult<Antree>> confirmAntree(Antree antree);
  Future<ResponseResult<Antree>> takeOrder(Antree antree);
}

@Injectable(as: StatusAntreeRepository)
class StatusAntreeRepositoryImpl implements StatusAntreeRepository {
  final ApiClient _apiClient;
  final AntreeRepository _antreeRepository;
  final SharedPrefsRepository _sharedPrefsRepository;

  StatusAntreeRepositoryImpl(
      this._apiClient, this._antreeRepository, this._sharedPrefsRepository);

  @override
  Future<ResponseResult<Antree>> updateStatusAntree(Antree antree) async {
    if (antree.id == 0) return ResponseResult.error('Antree Id is empty');
    if (antree.status.id == 0)
      return ResponseResult.error('Status Id is empty');
    final statusId = antree.status.id;
    final mapUpdateStatus = antree.toUpdateStatus;
    if (statusId == 3) {
      logger.d('statusId($statusId) -> decrease remaining on');
      mapUpdateStatus['remaining'] = 0;
    }
    if (statusId >= 5 && statusId <= 7) {
      logger.d('decrease remaining on');
      decreasingRemaining();
    }
    return updateAntree(antree.id, mapUpdateStatus.wrapWithData);
  }

  @override
  Future<ResponseResult<Antree>> confirmAntree(Antree antree) async {
    logger.d('Confirm -> ${antree.id}');
    if (antree.id == 0) return ResponseResult.error('Antree Id is empty');
    if (antree.status.id == 0)
      return ResponseResult.error('Status Id is empty');
    final status = antree.status;
    antree = antree.copyWith(status: status.copyWith(id: (status.id + 1)));
    final nomorAntree = await getNomorAntree();
    final remaining = nomorAntree != null ? (nomorAntree - 1) : null;
    // final remaining = await getRemaining(antree);
    final Map<String, dynamic> mapConfrimAntree = antree.toUpdateStatus;
    if (nomorAntree != null) mapConfrimAntree["nomorAntree"] = nomorAntree;
    if (remaining != null) mapConfrimAntree["remaining"] = remaining;
    logger.d(mapConfrimAntree);
    return updateAntree(antree.id, mapConfrimAntree.wrapWithData);
  }

  Future<ResponseResult<Antree>> updateAntree(
      int antreeId, BaseBody updatedBody) {
    BaseBody queries = {
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };

    return _apiClient.antree
        .updateAntree(antreeId, updatedBody, queries)
        .awaitResponse;
  }

  Future<int?> getNomorAntree() async {
    final merchantId = _sharedPrefsRepository.account?.user.merchantId;
    if (merchantId == null) return null;
    final date = DateTime.now();
    final String now = DateFormat("yyyy-MM-dd").format(date);
    final String tomorrow =
        DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
    final Map<String, dynamic> nomorAntreeQuery = {
      'filters[merchant]': merchantId,
      'pagination[pageSize]': 10,
      'filters[createdAt][\$gte]': now,
      'filters[createdAt][\$lt]': tomorrow
    };
    final response =
        await _antreeRepository.getMerchantAntrees(query: nomorAntreeQuery);
    int? nomorAntree = response.whenOrNull(
      data: (data, meta) => meta?.pagination.total,
      error: (message) => null,
    );
    logger.d(nomorAntree);
    return nomorAntree != null ? nomorAntree : null;
  }

  void decreasingRemaining() async {
    final merchantId = _sharedPrefsRepository.account?.user.merchantId;
    if (merchantId == null) return null;
    final date = DateTime.now();
    final String now = DateFormat("yyyy-MM-dd").format(date);
    final String tomorrow =
        DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
    final Map<String, dynamic> nomorAntreeQuery = {
      'filters[merchant]': merchantId,
      'filters[isVerify]': false,
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
      'filters[status][id][\$eq]': 2,
      'filters[createdAt][\$gte]': now,
      'filters[createdAt][\$lt]': tomorrow,
    };
    final response =
        await _antreeRepository.getMerchantAntrees(query: nomorAntreeQuery);
    response.whenOrNull(
      data: (data, meta) async {
        data.forEach((element) async {
          logger.d(
              'decrease -> ${element.id} | remaining -> ${element.remaining}');
          final remaining = element.remaining;
          if (remaining != null || remaining != 0) {
            BaseBody decreaseRemaining = {"remaining": (remaining! - 1)};
            logger.d('updating remaining w other antree');
            await updateAntree(element.id, decreaseRemaining.wrapWithData);
          }
        });
      },
    );
  }

  @override
  Future<ResponseResult<Antree>> takeOrder(Antree antree) async {
    final takenAt = DateTime.now();
    BaseBody queries = {
      'populate[customer][populate][0]': 'user',
      'populate[orders]': '*',
      'populate[status]': '*',
    };

    return _apiClient.antree
        .updateAntree(
            antree.id, antree.toTakeOrder(takenAt).wrapWithData, queries)
        .awaitResponse;
  }

  // Future<int?> getRemaining(Antree antree) async {
  //   final date = DateTime.now();
  //   final String now = DateFormat("yyyy-MM-dd").format(date);
  //   final String tomorrow =
  //       DateFormat("yyyy-MM-dd").format(date.add(Duration(days: 1)));
  //   final Map<String, dynamic> nomorAntreeQuery = {
  //     'filters[merchant]': antree.merchant.id,
  //     'pagination[pageSize]': 10,
  //     'filters[createdAt][\$gte]': now,
  //     'filters[createdAt][\$lt]': tomorrow,
  //     'fliters[isVerify][\$eq]': false
  //   };
  //   final response =
  //       await _antreeRepository.getMerchantAntrees(query: nomorAntreeQuery);
  //   return 0;
  // }
}
