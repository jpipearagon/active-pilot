
import 'dart:async';

import '../apis/aircraft_api.dart';
import '../models/AircraftDocumentDetail.dart';

class AircraftBloc {
  static final AircraftBloc _singleton = AircraftBloc._internal();

  AircraftBloc._internal();

  // ignore: close_sinks
  final _aircraftDocumentsStreamController =
  StreamController<List<AircraftDocumentDetail>>.broadcast();
  Function(List<AircraftDocumentDetail>) get aircraftSink =>
      _aircraftDocumentsStreamController.sink.add;
  Stream<List<AircraftDocumentDetail>> get aircraftStream =>
      _aircraftDocumentsStreamController.stream;

  factory AircraftBloc() {
    return _singleton;
  }

  Future<void> loaddoucmentsAircraft(String aircraftId) async {
    final aircraftApi = AircraftApi();

    final response = await aircraftApi.getDocumentsAircraft(aircraftId);
    if(response != null) {
      aircraftSink(response);
    }
    return null;
  }
}
