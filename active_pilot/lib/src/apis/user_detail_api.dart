
import 'package:aircraft/src/models/UserDetail.dart';
import 'rest_api.dart';

class UserDetailApi {

  final RestApi _restApi = RestApi();

  Future<UserDetail> userDetail(String userId) async {
    try {
      final response = await _restApi.get(endPoint: "/api/users/"+userId);
      return UserDetail.fromJson(response);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}