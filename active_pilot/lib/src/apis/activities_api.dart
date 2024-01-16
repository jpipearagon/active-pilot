import 'package:aircraft/src/models/Activities.dart';

import 'rest_api.dart';

class ActivitiesApi {

  final RestApi _restApi = RestApi();

  Future<List<Activity>?> getActivities() async {
    try {
      List<dynamic> response = await _restApi.get(endPoint: "/api/activityTypes");
      final list = response.map((data) {
        return Activity.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}