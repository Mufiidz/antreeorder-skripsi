import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/seat.dart';
import 'package:antreeorder/utils/const.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'seat_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class SeatApiClient {
  factory SeatApiClient(Dio dio, {String baseUrl}) = _SeatApiClient;

  static const String seatsPath = '/seats';
  static const String idPath = '/{id}';
  static const String seatWithIdPath = '$seatsPath$idPath';
  static const String id = 'id';

  @POST(seatsPath)
  Future<BaseResponse<Seat>> createSeat(@Body() BaseBody data);

  @PUT(seatWithIdPath)
  Future<BaseResponse<Seat>> updateSeat(
      @Path(id) int id, @Body() BaseBody data);

  @GET(seatWithIdPath)
  Future<BaseResponse<Seat>> getSeat(@Path(id) int id);

  @GET(seatsPath)
  Future<BaseResponse<List<Seat>>> getSeats();

  @DELETE(seatWithIdPath)
  Future<BaseResponse<Seat>> deleteSeat(@Path(id) int id);
}
