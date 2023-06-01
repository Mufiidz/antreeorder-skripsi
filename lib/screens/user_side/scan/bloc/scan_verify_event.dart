part of 'scan_verify_bloc.dart';

@freezed
class ScanVerifyEvent with _$ScanVerifyEvent {
  const factory ScanVerifyEvent.initial() = _ScanVerifyInitial;
  const factory ScanVerifyEvent.takenAntree(String qrcode, Antree currentAntree) = _ScanVerifyTakenAntree;
}
