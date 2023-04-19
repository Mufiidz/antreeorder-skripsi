import 'package:intl/intl.dart';

extension CurrencyFormat on int {
  String toIdr() => NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(this);
}
