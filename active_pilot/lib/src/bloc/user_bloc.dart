import 'dart:async';

import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/models/LogBook.dart';
import 'package:aircraft/src/models/UserDocuments.dart';
import 'package:aircraft/src/models/Endorsment.dart';
import 'package:aircraft/src/models/UserTotals.dart';
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
      StreamController<List<UserDocuments>>.broadcast();
  Function(List<UserDocuments>) get documentstSink =>
      _documentsStreamController.sink.add;
  Stream<List<UserDocuments>> get documentsStream =>
      _documentsStreamController.stream;

  // ignore: close_sinks
  final _logBookStreamController =
  StreamController<List<LogBook>>.broadcast();
  Function(List<LogBook>) get logBookSink =>
      _logBookStreamController.sink.add;
  Stream<List<LogBook>> get logBookStream =>
      _logBookStreamController.stream;

  // ignore: close_sinks
  final _totalsStreamController =
  StreamController<UserTotals>.broadcast();
  Function(UserTotals) get userTotalSink =>
      _totalsStreamController.sink.add;
  Stream<UserTotals> get userTotalStream =>
      _totalsStreamController.stream;

  factory UserBloc() {
    return _singleton;
  }

  Future<void> loadEndorsments() async {
    final userDetailApi = UserDetailApi();
    final prefs = SharedPreferencesUser();

    final response = await userDetailApi.getUserEndorsment(prefs.userId);
    if(response != null) {
      endorsmentSink(response);
    }
    return null;
  }

  Future<void> loadDocuments() async {
    final userDetailApi = UserDetailApi();
    final prefs = SharedPreferencesUser();

    final response = await userDetailApi.getUserDocuments(prefs.userId);
    if(response != null) {
      documentstSink(response);
    }
    return null;
  }

  Future<void> loadLogBook() async {
    final userDetailApi = UserDetailApi();
    final prefs = SharedPreferencesUser();

    final response = await userDetailApi.getUserLogBook(prefs.userId);
    if(response != null) {
      logBookSink(response);
    }
    return null;
  }

  Future<void> loadTotals() async {
    final userDetailApi = UserDetailApi();

    final response = await userDetailApi.getUserTotals();
    userTotalSink(response);

    return null;
  }
}
