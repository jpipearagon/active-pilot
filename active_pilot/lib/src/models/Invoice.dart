import 'Reservation.dart';

class Invoice {
  String? sId;
  Reservation? reservation;
  String? amount;
  bool? paid;
  String? status;

  Invoice({this.sId, this.reservation, this.amount, this.paid, this.status});

  Invoice.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reservation = Reservation.fromJson(json['reservation']);
    amount = json['amount'];
    paid = json['paid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['reservation'] = this.reservation;
    data['amount'] = this.amount;
    data['paid'] = this.paid;
    data['status'] = this.status;
    return data;
  }
}