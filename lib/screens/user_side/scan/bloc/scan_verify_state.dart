part of 'scan_verify_bloc.dart';

@freezed
class ScanVerifyState with _$ScanVerifyState {
  const factory ScanVerifyState({
    @Default(CameraStatus.initial) CameraStatus cameraStatus,
      @Default(Antree()) Antree antree,
      @Default(StatusState.idle) StatusState status,
      @Default('') String message,
      }) = _ScanVerifyState;
}

enum CameraStatus { initial, granted, denied, deniedPermanent }
