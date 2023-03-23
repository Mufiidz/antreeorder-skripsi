import 'package:flutter/material.dart';

class AntreeText extends StatelessWidget {
  final String text;
  final AntreeTextType textType;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle? style;
  final double fontSize;
  const AntreeText(
    this.text, {
    Key? key,
    this.textType = AntreeTextType.normal,
    this.textAlign,
    this.maxLines,
    this.style,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style ?? _getTextStyle(fontSize),
    );
  }

  TextStyle _getTextStyle(double fontSize) {
    TextStyle textStyle =
        TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal);
    switch (textType) {
      case AntreeTextType.title:
        textStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.w800);
        break;
      case AntreeTextType.medium:
        textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
        break;
      case AntreeTextType.bold:
        textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
        break;
      case AntreeTextType.light:
        textStyle = textStyle.copyWith(fontWeight: FontWeight.w200);
        break;
      default:
        textStyle = textStyle;
    }

    return textStyle;
  }
}

enum AntreeTextType { title, medium, normal, bold, light }
