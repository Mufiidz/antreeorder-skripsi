import 'package:intl/intl.dart';

extension IntExt on int {
  String toIdr() => NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(this);
}
