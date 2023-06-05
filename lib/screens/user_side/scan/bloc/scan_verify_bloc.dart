import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/repository/status_antree_repository.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scan_verify_event.dart';
part 'scan_verify_state.dart';
part 'scan_verify_bloc.freezed.dart';

@injectable
class ScanVerifyBloc extends Bloc<ScanVerifyEvent, ScanVerifyState> {
  final StatusAntreeRepository _statusAntreeRepository;
  ScanVerifyBloc(this._statusAntreeRepository) : super(ScanVerifyState()) {
    on<ScanVerifyEvent>((event, emit) async {
      final resultState = await event.when(
        initial: () async {
          final permissionStatus = await Permission.camera.request();
          final cameraStatus = getCameraStatus(permissionStatus);
          return state.copyWith(cameraStatus: cameraStatus, isReadyScan: true);
        },
        takenAntree: (String qrcode, Antree currentAntree) async {
          var newState = state.copyWith(status: StatusState.loading, isReadyScan: false);
          if (qrcode.isEmpty)
            return state.copyWith(
                message: "Empty QrCode result", status: StatusState.failure, isReadyScan: true);
          final isVerified = qrcode.contain("AntreeOrder${currentAntree.id}");
          if (isVerified) {
            final response =
                await _statusAntreeRepository.takeOrder(currentAntree);
            newState = response.when(
              data: (data, meta) => state.copyWith(
                  status: StatusState.success,
                  antree: data,
                  message: 'Pesanan berhasil diambil', isReadyScan: true),
              error: (message) =>
                  state.copyWith(message: message, status: StatusState.failure, isReadyScan: true),
            );
          } else {
            newState = state.copyWith(
                message: "Sorry you're not verified",
                status: StatusState.failure, isReadyScan: true);
          }
          return newState;
        },
      );
      emit(resultState);
    });
  }

  CameraStatus getCameraStatus(PermissionStatus permissionStatus) {
    if (permissionStatus.isGranted) return CameraStatus.granted;
    if (permissionStatus.isDenied) return CameraStatus.denied;
    return CameraStatus.deniedPermanent;
  }
}
