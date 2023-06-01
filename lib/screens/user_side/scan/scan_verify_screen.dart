import 'package:ai_barcode/ai_barcode.dart';
import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/antree.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/res/antree_textstyle.dart';
import 'package:antreeorder/screens/user_side/scan/bloc/scan_verify_bloc.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'success_taken_screen.dart';

class ScanVerifyScreen extends StatefulWidget {
  final Antree antree;
  const ScanVerifyScreen(this.antree, {Key? key}) : super(key: key);

  @override
  State<ScanVerifyScreen> createState() => _ScanVerifyScreenState();
}

class _ScanVerifyScreenState extends State<ScanVerifyScreen> {
  late final ScanVerifyBloc _scanVerifyBloc;
  late final AntreeLoadingDialog _loading;
  late final ScannerController _scannerController;

  @override
  void initState() {
    _loading = getIt<AntreeLoadingDialog>();
    _scanVerifyBloc = getIt<ScanVerifyBloc>();
    _scanVerifyBloc.add(ScanVerifyEvent.initial());
    _scannerController = ScannerController(
        scannerResult: (result) => _scanVerifyBloc
            .add(ScanVerifyEvent.takenAntree(result, widget.antree)),
        scannerViewCreated: () {
          if (context.platform == TargetPlatform.iOS) {
            Future.delayed(Duration(seconds: 2), () {
              _scannerController.startCamera();
              _scannerController.startCameraPreview();
            });
          } else {
            _scannerController.startCamera();
            _scannerController.startCameraPreview();
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar('Verify My Order'),
      body: BlocConsumer<ScanVerifyBloc, ScanVerifyState>(
        bloc: _scanVerifyBloc,
        listener: (context, state) {
          if (state.status == StatusState.loading) {
            _loading.showLoadingDialog(context);
          }
          if (state.status == StatusState.success) {
            _loading.dismiss();
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.success,
            ));
            AppRoute.clearAll(SuccessTakenScreen(antree: state.antree));
          }
          if (state.status == StatusState.failure) {
            _loading.dismiss();
            context.snackbar.showSnackBar(AntreeSnackbar(
              state.message,
              status: SnackbarStatus.error,
            ));
          }
          if (state.status == StatusState.idle) {
            _loading.dismiss();
          }
        },
        builder: (context, state) {
          final isDeniedPermanent =
              state.cameraStatus == CameraStatus.deniedPermanent;
          if (state.cameraStatus == CameraStatus.granted) {
            return PlatformAiBarcodeScannerWidget(
                platformScannerController: _scannerController);
          }
          return Container(
            width: context.mediaSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: SizedBox(
                height: context.mediaSize.height / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AntreeText(
                      'Camera Permission Denied',
                      style: AntreeTextStyle.medium.bold,
                    ),
                    AntreeSpacer(),
                    AntreeText(
                      'Your camera permission is ${isDeniedPermanent ? 'Permanently Denied' : 'Denied'}, you must grant camera for use this.',
                      textAlign: TextAlign.center,
                    ),
                    AntreeSpacer(
                      size: 20,
                    ),
                    AntreeButton(
                      width: context.mediaSize.width,
                      isDeniedPermanent ? 'Settings' : 'Request',
                      onClick: () async {
                        if (isDeniedPermanent) {
                          final result = await openAppSettings();
                          if (result) {
                            _scanVerifyBloc.add(ScanVerifyEvent.initial());
                          }
                        } else {
                          _scanVerifyBloc.add(ScanVerifyEvent.initial());
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scannerController.stopCamera();
    _scannerController.stopCameraPreview();
    super.dispose();
  }
}
