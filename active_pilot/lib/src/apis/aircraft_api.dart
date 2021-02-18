import 'package:aircraft/src/models/Activities.dart';
import 'package:aircraft/src/models/Aircraft.dart';

import 'rest_api.dart';

class AircraftApi {

  final RestApi _restApi = RestApi();

  Future<List<Aircraft>> getAircrafts() async {
    try {
      final Map<String, String> params =
      {
        "_populate[0]": "aircraftMaker",
        "_populate[1]": "aircraftModel",
      };
      List<dynamic> response = await _restApi.get(endPoint: "/api/aircrafts", queryParameters: params);
      final list = response.map((data) {
        return Aircraft.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Aircraft>> getAvailableAircrafts(String startDate, String endDate, String locationId, String activityId, List<String> aircraftCategory) async {
    try {
      final Map<String, String> params =
      {
        "start": startDate,
        "end": endDate,
        "location" : locationId,
        "activity" : activityId,
        "_populate[0]": "aircraftMaker",
        "_populate[1]": "aircraftModel",
      };

      for (var i = 0; i < aircraftCategory.length; i++) {
        params["aircraftCategory[$i]"] = aircraftCategory[i];
      }

      List<dynamic> response = await _restApi.get(endPoint: "/api/aircrafts/listAvailable", queryParameters: params);
      final list = response.map((data) {
        return Aircraft.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}