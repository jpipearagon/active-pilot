
import 'dart:async';
import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/models/UserDetail.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';

class ProfileBloc {

  static final ProfileBloc _singleton = ProfileBloc._internal();

  ProfileBloc._internal();

  StreamController _profileController = StreamController<UserDetail>.broadcast();
  Stream<UserDetail> get streamProfile => _profileController.stream;

  factory ProfileBloc() {
    return _singleton;
  }

  dispose() {
    _profileController?.close();
  }

  Future<Null> loadProfile() async {
    final prefs = SharedPreferencesUser();
    final userDetail = UserDetailApi();
    final response = await userDetail.userDetail(prefs.userId);
    _profileController.sink.add(response);
    return null;
  }

}