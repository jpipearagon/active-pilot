class StringUtil {
  static int MINUTES_IN_AN_HOUR = 60;
  static int SECONDS_IN_A_MINUTE = 60;

  static String convertNumberToHoursMinutes(
    String number,
  ) {
    double numberDouble = double.parse(number);
    bool isNegative = false;
    if (numberDouble.isNegative) {
      numberDouble = numberDouble * -1;
      isNegative = true;
    }
    int totalSeconds = (numberDouble * 3600).toInt();
    int totalMinutes = totalSeconds ~/ StringUtil.SECONDS_IN_A_MINUTE;
    int minutes = totalMinutes % MINUTES_IN_AN_HOUR;
    int hours = totalMinutes ~/ MINUTES_IN_AN_HOUR;

    String hoursStr = hours < 10 ? '0$hours' : '$hours';
    String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
    var symbol = isNegative ? '-' : '+';
    return '$symbol$hoursStr:$minutesStr';
  }
}
