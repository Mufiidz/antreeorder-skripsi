import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_notif.freezed.dart';
part 'firebase_notif.g.dart';

@freezed
class FirebaseNotif with _$FirebaseNotif {
  factory FirebaseNotif({
    @Default(0.0) double multicastId,
    @Default(0) int success,
    @Default(0) int failure,
    @Default(0) int canonicalIds,
    @Default([]) List<FirebaseNotifResult> results,
  }) = _FirebaseNotif;

  factory FirebaseNotif.fromJson(Map<String, dynamic> json) =>
      _$FirebaseNotifFromJson(json);
}

@freezed
class FirebaseNotifResult with _$FirebaseNotifResult {
  factory FirebaseNotifResult({@Default('') String messageId, @Default('') String error}) =
      _FirebaseNotifResult;

  factory FirebaseNotifResult.fromJson(Map<String, dynamic> json) =>
      _$FirebaseNotifResultFromJson(json);
}
