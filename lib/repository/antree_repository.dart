import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class AntreeRepository {
  Future<ApiResponse<Antree>> add(Antree antree);
  Future<ApiResponse<Antree>> detail(String antreeId);
  Future<ApiResponse<Antree>> pickup(String antreeId, bool isVerify);
  Future<ApiResponse<List<Antree>>> listAntree(String userId);
  Future<ApiResponse<Antree>> updateStatusAntree(String antreeId, int statusId);
}

@Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;

  AntreeRepositoryImpl(@factoryMethod this._apiClient);
  @override
  Future<ApiResponse<Antree>> add(Antree antree) =>
      _apiClient.antree.addAntree(antree).awaitResult;

  @override
  Future<ApiResponse<Antree>> detail(String antreeId) =>
      _apiClient.antree.detailAntree(antreeId).awaitResult;

  @override
  Future<ApiResponse<Antree>> pickup(String antreeId, bool isVerify) =>
      _apiClient.antree.pickupAntree(antreeId, isVerify);

  @override
  Future<ApiResponse<Antree>> updateStatusAntree(
          String antreeId, int statusId) =>
      _apiClient.antree.updateStatusAntree(antreeId, statusId).awaitResult;

  @override
  Future<ApiResponse<List<Antree>>> listAntree(String userId) =>
      _apiClient.antree.listAntree(userId).awaitResult;
}
