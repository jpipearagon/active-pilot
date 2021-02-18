import 'dart:async';

import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';

class UserBloc {
  static final UserBloc _singleton = UserBloc._internal();

  UserBloc._internal();

  // ignore: close_sinks
  final _endorsmentStreamController =
      StreamController<List<Endorsment>>.broadcast();
  Function(List<Endorsment>) get scheduleSink =>
      _endorsmentStreamController.sink.add;
  Stream<List<Endorsment>> get scheduleStream =>
      _endorsmentStreamController.stream;

  factory UserBloc() {
    return _singleton;
  }

  Future<void> loadEndorsments() async {
    final userDetailApi = UserDetailApi();
    final prefs = SharedPreferencesUser();

    userDetailApi.getUserEndorsment(prefs.userId);

    /*var timeZoneOffset = DateTime.now().timeZoneOffset;
    var timeZone = StringUtil.convertNumberToHoursMinutes(
        (timeZoneOffset.inMinutes / 60).toString());

    String startDate =
        DateUtil.getDateStringFromDateTime(date, DateUtil.yyyyMMdd);

    final response = await scheduleApi.getScheduleByDate(
        '$startDate' + 'T00:00:00$timeZone',
        '$startDate' + 'T23:59:59$timeZone');
    scheduleSink(response);*/
    return null;
  }
}
