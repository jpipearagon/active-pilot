

import 'package:aircraft/src/apis/rest_api.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/models/ReservationStatus.dart';
import 'package:aircraft/src/models/UserRole.dart';

class ReservationApi {

  final RestApi _restApi = RestApi();

  Future<dynamic> createReservation(String startDate, String endDate, String activityId, String aircraftId, String instructorId, String pilotId) async {

    var response;
    try {
      final Map<String, String> params = {
        "start": startDate,
        "end": endDate,
        "activityId": activityId,
        "aircraftId": aircraftId,
        "instructorId": instructorId,
        "pilotId": pilotId
      };
      response = await _restApi.post(endPoint: "/api/reservations/", queryParameters: params);
      return Reservation.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> changeStatusReservation(String reservationId, ReservationStatus reservationStatus) async {

    var response;
    try {
      final Map<String, String> params = {
        "statusId": enumValueToString(reservationStatus),
      };
      response = await _restApi.patch(endPoint: "/api/reservations/"+reservationId, queryParameters: params);
      return Reservation.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}