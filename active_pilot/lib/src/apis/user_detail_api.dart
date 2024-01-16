import 'package:aircraft/src/models/ImageFile.dart';
import 'package:aircraft/src/models/LogBook.dart';
import 'package:aircraft/src/models/UserDocuments.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/src/models/UserDetail.dart';

import '../models/UserTotals.dart';
import 'rest_api.dart';

class UserDetailApi {
  final RestApi _restApi = RestApi();

  Future<UserDetail?> userDetail(String userId) async {
    try {
      final response = await _restApi.get(endPoint: "/api/users/" + userId);
      return UserDetail.fromJson(response);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Endorsment>?> getUserEndorsment(String userId) async {
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

  Future<List<UserDocuments>?> getUserDocuments(String userId) async {
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
        return UserDocuments.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> addFilesDocument(String idDocument, Map<String, String> fields, List<ImageFile> files) async {

    var response;
    try {
      response = await _restApi.multipart(method: "PATCH", endPoint: "/api/userDocuments/"+idDocument, fields: fields, files: files);
      return UserDocuments.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> removeFilesDocument(String idDocument, String idFile) async {

    var response;
    try {
      response = await _restApi.delete(endPoint: "/api/userDocuments/" + idDocument + "/deleteFile/" + idFile);
      return UserDocuments.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<LogBook>?> getUserLogBook(String userId) async {
    try {
      List<dynamic> response = await _restApi.get(
          endPoint: '/api/logbook');
      final list = response.map((data) {
        return LogBook.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> updateLogBook(String logBookId, Map<String, String> params) async {
    var response;
    try {
      response = await _restApi.patch(endPoint: "/api/logbook/"+logBookId, queryParameters: params);
      return LogBook.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> updateUser(String userId, Map<String, String> fields, List<ImageFile> files) async {

    var response;

    if (files.isEmpty) {
      try {
        response = await _restApi.patch(endPoint: "/api/users/"+userId, queryParameters: fields);
        return UserDetail.fromJson(response);
      } catch (e) {
        return e.toString();
      }
    } else {
      try {
        response = await _restApi.multipart(method: "PATCH", endPoint: "/api/users/"+userId, fields: fields, files: files);
        return UserDetail.fromJson(response);
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<dynamic> updateInstructor(String userId, Map<String, String> fields) async {

    var response;

    try {
      response = await _restApi.patch(endPoint: "/api/instructors/"+userId, queryParameters: fields);
      return Instructor.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getUserTotals() async {

    var response;

    try {
      response = await _restApi.get(endPoint: "/api/users/totals");
      return UserTotals.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}
