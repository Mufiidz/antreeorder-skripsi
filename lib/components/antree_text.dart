import 'package:flutter/material.dart';

import '../res/antree_textstyle.dart';

class AntreeText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle style;
  final TextOverflow? overflow;
  final Color textColor;
  final double? fontSize;
  const AntreeText(this.text,
      {Key? key,
      this.textAlign,
      this.maxLines,
      this.style = AntreeTextStyle.normal,
      this.overflow = TextOverflow.ellipsis,
      this.textColor = Colors.black,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: textColor, fontSize: fontSize),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
