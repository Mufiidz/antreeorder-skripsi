import 'package:flutter/material.dart';

class AntreeSpacer extends StatelessWidget {
  final double? size;
  final bool isVertical;
  const AntreeSpacer({Key? key, this.size = 10, this.isVertical = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? 0 : size,
      height: isVertical ? size : 0,
    );
  }
}
