import 'package:flutter/material.dart';

import '../res/antree_textstyle.dart';

class AntreeText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle style;
  final double? fontSize;
  final Color? textColor;
  const AntreeText(
    this.text, {
    Key? key,
    this.textAlign,
    this.maxLines,
    this.style = AntreeTextStyle.normal,
    this.fontSize,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style.copyWith(fontSize: fontSize, color: textColor),
    );
  }
}
