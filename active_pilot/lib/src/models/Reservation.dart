import 'package:aircraft/src/models/ReservationStatus.dart';

class Reservation {
  String id;
  String startDate;
  String endDate;
  String pilot;
  String activityType;
  ReservationStatus reservationStatus;

  Reservation({
    this.id,
    this.startDate,
    this.endDate,
    this.pilot,
    this.activityType,
    this.reservationStatus,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json['_id'],
        startDate: json['start'],
        endDate: json['end'],
        activityType: json['activity']['name'],
        pilot: json['pilot']['firstName'] + ' ' + json['pilot']['lastName'],
        reservationStatus: ReservationStatus.fromJson(json['status']));
  }
}
