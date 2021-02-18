import 'package:aircraft/src/models/UserDetail.dart';

import 'rest_api.dart';

class InstructorApi {

  final RestApi _restApi = RestApi();

  Future<List<UserDetail>> getInstructors() async {
    try {
      List<dynamic> response = await _restApi.get(endPoint: "/api/instructors/");
      final list = response.map((data) {
        return UserDetail.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<UserDetail>> getAvailableInstructor(String startDate, String endDate, String locationId) async {
    try {
      final Map<String, String> params = {
        "start": startDate,
        "end": endDate,
        "location": locationId
      };
      List<dynamic> response = await _restApi.get(endPoint: "/api/instructors/listAvailable", queryParameters: params);
      final list = response.map((data) {
        return UserDetail.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}