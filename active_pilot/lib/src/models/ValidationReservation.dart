import 'CheckoutResponse.dart';
import 'Reservation.dart';

class ValidationReservation {
  String? sId;
  Status? status;
  Checkout? checkout;

  ValidationReservation({this.sId, this.status, this.checkout});

  ValidationReservation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    checkout = json['checkout'] != null
        ? new Checkout.fromJson(json['checkout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.status != null) {
      data['status'] = this.status?.toJson();
    }
    if (this.checkout != null) {
      data['checkout'] = this.checkout?.toJson();
    }
    return data;
  }
}