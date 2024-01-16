import 'Reservation.dart';

class ResponseGeneratePayment {
  bool? success;
  Paying? paying;
  Status? status;
  String? summary;

  ResponseGeneratePayment({this.success, this.paying, this.status, this.summary});

  ResponseGeneratePayment.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    paying =
    json['paying'] != null ? new Paying.fromJson(json['paying']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.paying != null) {
      data['paying'] = this.paying?.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status?.toJson();
    }
    data['summary'] = this.summary;
    return data;
  }
}

class Paying {
  String? giv;
  String? fiv;
  String? iv;
  String? afv;
  String? fv;

  Paying({this.giv, this.fiv, this.iv, this.afv, this.fv});

  Paying.fromJson(Map<String, dynamic> json) {
    giv = json['giv'] != null ? json['giv'] : null;
    fiv = json['fiv'] != null ? json['fiv'] : null;
    iv = json['iv'] != null ? json['iv'] : null;
    afv = json['afv'] != null ? json['afv'] : null;
    fv = json['fv'] != null ? json['fv'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.giv != null) {
      data['giv'] = this.giv;
    }
    if (this.fiv != null) {
      data['fiv'] = this.fiv;
    }
    if (this.iv != null) {
      data['iv'] = this.iv;
    }
    if (this.afv != null) {
      data['afv'] = this.afv;
    }
    if (this.fv != null) {
      data['fv'] = this.fv;
    }
    return data;
  }
}

class Giv {
  String? numberDecimal;

  Giv({this.numberDecimal});

  Giv.fromJson(Map<String, dynamic> json) {
    numberDecimal = json['$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$numberDecimal'] = this.numberDecimal;
    return data;
  }
}