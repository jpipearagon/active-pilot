import 'package:aircraft/src/models/Reservation.dart';

import 'rest_api.dart';

class ScheduleApi {
  final RestApi _restApi = RestApi();

  Future<List<Reservation>> getScheduleByDate(
      String startDate, String endDate) async {
    try {
      final Map<String, String> params = {
        "start": startDate,
        "end": endDate,
      };

      List<dynamic> response = await _restApi.get(
          endPoint: '/api/reservations', queryParameters: params);
      final list = response.map((data) {
        return Reservation.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
