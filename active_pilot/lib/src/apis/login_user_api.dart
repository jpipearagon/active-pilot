import 'package:aircraft/src/models/LoginUser.dart';

import 'rest_api.dart';

class LoginUserApi {

  final RestApi _restApi = RestApi();

  Future<dynamic> loginUser(String username, String password) async {
    try {
      final Map<String, String> params = {
        "username": username,
        "password": password
      };
      final response = await _restApi.post(endPoint: "/token/login", queryParameters: params);
      return LoginUser.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}