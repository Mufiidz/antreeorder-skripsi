import 'package:flutter/material.dart';

class AntreeSnackbar extends SnackBar {
  final String message;
  final SnackbarStatus status;
  AntreeSnackbar(this.message, {super.key, this.status = SnackbarStatus.normal})
      : super(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            backgroundColor: _snackbarColor(status));

  static Color? _snackbarColor(SnackbarStatus status) {
    Color? color;
    switch (status) {
      case SnackbarStatus.success:
        color = Colors.green;
        break;
      case SnackbarStatus.error:
        color = Colors.red;
        break;
      default:
        color = null;
    }
    return color;
  }
}

enum SnackbarStatus { normal, error, success }
