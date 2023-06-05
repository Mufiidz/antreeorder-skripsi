import 'package:antreeorder/config/api_client.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/utils/const.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_apiclient.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class NotificationApiClient {
  factory NotificationApiClient(Dio dio, {String baseUrl}) =
      _NotificationApiClient;

  static const String notifPath = '/notifications';
  static const String idPath = '/{id}';
  static const String notifWithIdPath = '$notifPath$idPath';
  static const String id = 'id';

  @POST(notifPath)
  Future<BaseResponse<Notification>> createNotification(@Body() BaseBody data);

  @GET(notifPath)
  Future<BaseResponse<List<Notification>>> getNotifications(
      @Queries() BaseBody queries);

  @PUT(notifWithIdPath)
  Future<BaseResponse<Notification>> updateNotification(
      @Path(id) int notificationId,
      @Body() BaseBody data,
      @Queries() BaseBody queries);
}
