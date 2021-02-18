import 'dart:async';

import 'package:aircraft/src/apis/schedule_api.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/utils/date_util.dart';
import 'package:aircraft/utils/string_util.dart';

class ScheduleBloc {
  static final ScheduleBloc _singleton = ScheduleBloc._internal();

  ScheduleBloc._internal();

  // ignore: close_sinks
  final _scheduleStreamController =
      StreamController<List<Reservation>>.broadcast();
  Function(List<Reservation>) get scheduleSink =>
      _scheduleStreamController.sink.add;
  Stream<List<Reservation>> get scheduleStream =>
      _scheduleStreamController.stream;

  factory ScheduleBloc() {
    return _singleton;
  }

  Future<void> loadSchedule(DateTime date) async {
    final scheduleApi = ScheduleApi();

    var timeZoneOffset = DateTime.now().timeZoneOffset;
    var timeZone = StringUtil.convertNumberToHoursMinutes(
        (timeZoneOffset.inMinutes / 60).toString());

    String startDate =
        DateUtil.getDateStringFromDateTime(date, DateUtil.yyyyMMdd);

    final response = await scheduleApi.getScheduleByDate(
        '$startDate' + 'T00:00:00$timeZone',
        '$startDate' + 'T23:59:59$timeZone');
    scheduleSink(response);
    return null;
  }
}
