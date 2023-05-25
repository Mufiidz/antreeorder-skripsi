import 'package:flutter/material.dart';

class AntreeTextStyle {
  /// TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black)
  static const TextStyle normal = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black);

  /// TextStyle(fontSize: 30, fontWeight: FontWeight.w800)
  static TextStyle title = normal.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w800,
  );

  /// TextStyle(fontSize: 20, fontWeight: FontWeight.w400)
  static TextStyle medium =
      normal.copyWith(fontSize: 20, fontWeight: FontWeight.w400);

  /// TextStyle(fontSize: 14, fontWeight: FontWeight.light)
  static TextStyle light = normal.light;

  /// TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
  static TextStyle bold = normal.bold;
}

extension TextStyleExt on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get light => copyWith(fontWeight: FontWeight.w200);
}
