import 'package:flutter/material.dart';

class AntreeData extends StatelessWidget {
  final String message;
  final bool isData;
  final Widget child;
  final Widget? noData;
  const AntreeData(this.isData,
      {Key? key, this.message = 'Empty Data', required this.child, this.noData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isData
        ? child
        : noData ??
            Center(
              child: Text(message),
            );
  }
}
