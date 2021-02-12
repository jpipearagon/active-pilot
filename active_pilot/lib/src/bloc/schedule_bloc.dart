import 'dart:async';

import 'package:aircraft/src/apis/schedule_api.dart';
import 'package:aircraft/src/models/Reservation.dart';

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

  Future<void> loadSchedule() async {
    final scheduleApi = ScheduleApi();
    final response = await scheduleApi.getScheduleByDate(
        '2021-02-08T00:00:00-05:00', '2021-02-08T23:59:59-05:00');
    scheduleSink(response);
    return null;
  }
}
