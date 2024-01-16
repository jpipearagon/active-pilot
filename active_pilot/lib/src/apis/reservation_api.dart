

import 'package:aircraft/src/apis/rest_api.dart';
import 'package:aircraft/src/models/CheckinResponse.dart';
import 'package:aircraft/src/models/CheckoutResponse.dart';
import 'package:aircraft/src/models/ImageFile.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/models/ReservationStatus.dart';
import 'package:aircraft/src/models/UserRole.dart';
import 'package:aircraft/src/models/ValidationReservation.dart';

class ReservationApi {

  final RestApi _restApi = RestApi();

  Future<dynamic> createReservation(String startDate, String endDate, String activityId, String aircraftId, String instructorId, String pilotId, String locationId) async {

    var response;
    try {
      final Map<String, String> params = {
        "start": startDate,
        "end": endDate,
        "activityId": activityId,
        "aircraftId": aircraftId,
        "instructorId": instructorId,
        "pilotId": pilotId,
        "locationId": locationId
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

  Future<dynamic> checkoutReservation(String reservationId, Map<String, String> fields, List<ImageFile> files) async {

    var response;
    try {
      response = await _restApi.multipart(method: "PATCH", endPoint: "/api/checkout/"+reservationId, fields: fields, files: files);
      return CheckoutResponse.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> checkoutReservationValidation(String reservationId) async {
    try {
      final Map<String, String> params = {
        "id": reservationId
      };
      final response = await _restApi.post(endPoint: "/api/checkout", queryParameters: params);
      return ValidationReservation.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> checkinReservation(String reservationId, Map<String, String> fields, List<ImageFile> files) async {

    var response;
    try {
      response = await _restApi.multipart(method: "PATCH", endPoint: "/api/checkin/"+reservationId, fields: fields, files: files);
      return CheckinResponse.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> checkinReservationValidation(String reservationId) async {
    try {
      final Map<String, String> params = {
        "id": reservationId
      };
      final response = await _restApi.post(endPoint: "/api/checkin", queryParameters: params);
      return ValidationReservation.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}