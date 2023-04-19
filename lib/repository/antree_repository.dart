import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/api_response.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

import '../config/api_client.dart';

abstract class AntreeRepository {
  Future<ApiResponse<Antree>> add(Antree antree);
  Future<ApiResponse<Antree>> detail(String antreeId);
  Future<ApiResponse<Antree>> pickup(String antreeId, bool isVerify);
}

@Injectable(as: AntreeRepository)
class AntreeRepositoryImpl implements AntreeRepository {
  final ApiClient _apiClient;

  AntreeRepositoryImpl(@factoryMethod this._apiClient);
  @override
  Future<ApiResponse<Antree>> add(Antree antree) =>
      _apiClient.addAntree(antree).awaitResult;

  @override
  Future<ApiResponse<Antree>> detail(String antreeId) =>
      _apiClient.detailAntree(antreeId).awaitResult;

  @override
  Future<ApiResponse<Antree>> pickup(String antreeId, bool isVerify) =>
      _apiClient.pickupAntree(antreeId, isVerify);
}
