import 'package:intl/intl.dart';

class DateUtil {

  static const String HHmma = 'HH:mm a';
  static const String yyyyMMddHHmma ="yyyy/MM/dd HH:mm a";
  static const String yyyyMMdd = 'yyyy-MM-dd';
  static const String ddMMyyyy = 'dd/MM/yyyy';
  static const String MMddyyyy = 'MM/dd/yyyy';
  static const String MMMddyyyyHHmmaa ="MMM/dd/yyyy HH:mm a";
  static const String MMMddyyyy ="MMM/dd/yyyy";

  static String getDateFormattedFromString(String date, String toFormat) {
    if (date != null && date.isNotEmpty) {
      DateTime tempDate = DateTime.parse(date).toLocal();
      String formattedDate = DateFormat(toFormat).format(tempDate);
      return formattedDate;
    } else {
      return "";
    }
  }

  static String getDateStringFromDateTime(
    DateTime date,
    String toFormat,
  ) {
    String formattedDate = DateFormat(toFormat).format(date.toLocal());
    return formattedDate;
  }
}
