import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateTimeExt on DateTime {
  String toStringDate(
      {String pattern = 'EEEE, dd MMMM yyyy', String locale = 'id-ID'}) {
    initializeDateFormatting(locale);
    return DateFormat(pattern, locale).format(this);
  }
}
