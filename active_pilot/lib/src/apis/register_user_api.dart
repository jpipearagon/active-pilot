

import 'package:aircraft/src/models/RegisterUser.dart';

import 'rest_api.dart';

class RegisterUserApi {

  final RestApi _restApi = RestApi();

  Future<dynamic> registerUser(String firstName, String lastName, String password, String email, String phone, String idLocation) async {
    try {
      final Map<String, String> params = {
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "email": email,
        "phone": phone,
        "location._id": idLocation
      };
      final response = await _restApi.post(endPoint: "/api/users", queryParameters: params);
      return RegisterUser.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}