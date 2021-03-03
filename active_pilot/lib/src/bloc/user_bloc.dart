import 'dart:async';

import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/models/Document.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';

class UserBloc {
  static final UserBloc _singleton = UserBloc._internal();

  UserBloc._internal();

  // ignore: close_sinks
  final _endorsmentStreamController =
      StreamController<List<Endorsment>>.broadcast();
  Function(List<Endorsment>) get endorsmentSink =>
      _endorsmentStreamController.sink.add;
  Stream<List<Endorsment>> get endorsmentStream =>
      _endorsmentStreamController.stream;

  // ignore: close_sinks
  final _documentsStreamController =
      StreamController<List<Document>>.broadcast();
  Function(List<Document>) get documentstSink =>
      _documentsStreamController.sink.add;
  Stream<List<Document>> get documentsStream =>
      _documentsStreamController.stream;

  factory UserBloc() {
    return _singleton;
  }

  Future<void> loadEndorsments() async {
    final userDetailApi = UserDetailApi();
    final prefs = SharedPreferencesUser();

    final response = await userDetailApi.getUserEndorsment(prefs.userId);
    endorsmentSink(response);

    return null;
  }

  Future<void> loadDocuments() async {
    final userDetailApi = UserDetailApi();
    final prefs = SharedPreferencesUser();

    final response = await userDetailApi.getUserDocuments(prefs.userId);
    documentstSink(response);

    return null;
  }
}
