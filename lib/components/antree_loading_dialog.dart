import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';

class AntreeLoadingDialog {
  bool isShow = false;
  AntreeLoadingDialog();
  void showLoadingDialog(BuildContext context,
      {String message = '', bool dismissable = true}) {
    isShow = true;
    logger.d(isShow);
    showDialog(
        barrierDismissible: dismissable,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => dismissable,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          Visibility(
                              visible: message.isNotEmpty,
                              child: _content(message))
                        ],
                      ),
                    )),
              )),
            ));
  }

  static Widget _content(String message) => Column(
        children: [const AntreeSpacer(), Text(message)],
      );

  void dismiss() {
    if (isShow) {
      isShow = false;
      AppRoute.back();
    }
  }
}
