import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/utils/map_mapper.dart';
import 'package:antreeorder/utils/response_result.dart';
import 'package:antreeorder/utils/retrofit_ext.dart';
import 'package:injectable/injectable.dart';

abstract class SeatRepository {
  Future<ResponseResult<Seat>> addSeat(Seat seat);
  Future<ResponseResult<Seat>> updateSeat(Seat seat);
  Future<ResponseResult<Seat>> detailSeat(int seatId);
  Future<ResponseResult<Seat>> deleteSeat(int seatId);
  Future<ResponseResult<List<Seat>>> merchantSeats({int merchantId});
}

@Injectable(as: SeatRepository)
class SeatRepositoryImpl implements SeatRepository {
  final ApiClient _apiClient;
  final SharedPrefsRepository _sharedPrefsRepository;

  SeatRepositoryImpl(this._apiClient, this._sharedPrefsRepository);

  @override
  Future<ResponseResult<Seat>> addSeat(Seat seat) async {
    int seatsLength = 0;
    final int merchantId = _sharedPrefsRepository.user.merchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    final responseSeats = await merchantSeats();
    if (responseSeats is ResponseResultData<List<Seat>>) {
      seatsLength = responseSeats.data.length;
    }
    if (seatsLength == 0) {
      final newSeat = Seat(
          title: 'Take away',
          description: 'Untuk yang ingin dibawa pulang',
          quantity: 1,
          capacity: 0);

      ResponseResult<Seat> result = ResponseResult.error("Init");
      final newSeats = [newSeat, seat];
      for (var element in newSeats) {
        result = await _apiClient.seat
            .createSeat(element.toAddSeat(merchantId).wrapWithData)
            .awaitResponse;
        if (result is ResponseResultError<Seat>) break;
      }
      return result;
    }
    return await _apiClient.seat
        .createSeat(seat.toAddSeat(merchantId).wrapWithData)
        .awaitResponse;
  }

  @override
  Future<ResponseResult<Seat>> deleteSeat(int seatId) async {
    if (seatId == 0) return ResponseResult.error('Seat Id is empty');
    return _apiClient.seat.deleteSeat(seatId).awaitResponse;
  }

  @override
  Future<ResponseResult<Seat>> detailSeat(int seatId) async {
    if (seatId == 0) return ResponseResult.error('Seat Id is empty');
    return _apiClient.seat.getSeat(seatId).awaitResponse;
  }

  @override
  Future<ResponseResult<List<Seat>>> merchantSeats({int? merchantId}) async {
    final int currentMerchantId = _sharedPrefsRepository.user.merchantId;
    merchantId = merchantId ?? currentMerchantId;
    if (merchantId == 0) return ResponseResult.error('Merchant Id is empty');
    return _apiClient.seat.getSeats(merchantId).awaitResponse;
  }

  @override
  Future<ResponseResult<Seat>> updateSeat(Seat seat) async {
    if (seat.id == 0) return ResponseResult.error('Seat Id is empty');
    return _apiClient.seat
        .updateSeat(seat.id, seat.toUpdateSeat.wrapWithData)
        .awaitResponse;
  }
}
