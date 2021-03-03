import 'package:aircraft/src/models/Document.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/src/models/UserDetail.dart';

import 'rest_api.dart';

class UserDetailApi {
  final RestApi _restApi = RestApi();

  Future<UserDetail> userDetail(String userId) async {
    try {
      final response = await _restApi.get(endPoint: "/api/users/" + userId);
      return UserDetail.fromJson(response);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Endorsment>> getUserEndorsment(String userId) async {
    try {
      final Map<String, String> user = {
        '"user"': '"$userId"',
      };

      final Map<String, String> params = {
        "_filters": user.toString(),
      };

      List<dynamic> response = await _restApi.get(
          endPoint: '/api/endorsements', queryParameters: params);
      final list = response.map((data) {
        return Endorsment.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Document>> getUserDocuments(String userId) async {
    try {
      final Map<String, String> user = {
        '"user"': '"$userId"',
      };

      final Map<String, String> params = {
        "_filters": user.toString(),
      };

      List<dynamic> response = await _restApi.get(
          endPoint: '/api/userDocuments', queryParameters: params);
      final list = response.map((data) {
        return Document();
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
