import 'package:intl/intl.dart';

class DateUtil {
  static const String yyyyMmddTHHmmssz = 'yyyy-MM-ddTHH:mm:ss.SSSZ';
  static const String HHmm = 'HH:mm';
  static const String yyyyMMdd = 'yyyy-MM-dd';
  static const String ddMMyyyy = 'dd/MM/yyyy';

  static String getDateFormattedFromString(
    String date,
    String fromFormat,
    String toFormat,
  ) {
    DateTime tempDate = new DateFormat(fromFormat).parse(date);
    String formattedDate = DateFormat(toFormat).format(tempDate.toLocal());

    return formattedDate;
  }

  static String getDateStringFromDateTime(
    DateTime date,
    String toFormat,
  ) {
    String formattedDate = DateFormat(toFormat).format(date.toLocal());

    return formattedDate;
  }
}
