import 'CheckoutResponse.dart';

class CheckinResponse {
  String? sId;
  Checkin? checkin;
  int? iV;

  CheckinResponse({this.sId, this.checkin, this.iV});

  CheckinResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    checkin =
    json['checkin'] != null ? new Checkin.fromJson(json['checkin']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.checkin != null) {
      data['checkin'] = this.checkin?.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Checkin {
  List<ResponseImages>? discrepancyImages;
  double? hoobs;
  double? tach;
  double? fuel;
  double? oil;
  ResponseImages? hoobsImage;
  ResponseImages? tachImage;
  ResponseImages? fuelImage;
  ResponseImages? oilImage;
  String? description;

  Checkin(
      {this.discrepancyImages,
        this.hoobs,
        this.tach,
        this.fuel,
        this.oil,
        this.hoobsImage,
        this.tachImage,
        this.description});

  Checkin.fromJson(Map<String, dynamic> json) {
    if (json['discrepancyImages'] != null) {
      discrepancyImages = [];
      json['discrepancyImages'].forEach((v) {
        discrepancyImages?.add(new ResponseImages.fromJson(v));
      });
    }
    hoobs = json['hoobs'].toDouble();
    tach = json['tach'].toDouble();
    fuel = json['fuel'].toDouble();
    oil = json['oil'].toDouble();
    hoobsImage = json['hoobsImage'] != null
        ? new ResponseImages.fromJson(json['hoobsImage'])
        : null;
    tachImage = json['tachImage'] != null
        ? new ResponseImages.fromJson(json['tachImage'])
        : null;
    fuelImage = json['fuelImage'] != null
        ? new ResponseImages.fromJson(json['fuelImage'])
        : null;
    oilImage = json['oilImage'] != null
        ? new ResponseImages.fromJson(json['oilImage'])
        : null;
    description = json['description'] != null ? json['description']: "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discrepancyImages != null) {
      data['discrepancyImages'] =
          this.discrepancyImages?.map((v) => v.toJson()).toList();
    }
    data['hoobs'] = this.hoobs;
    data['tach'] = this.tach;
    data['fuel'] = this.fuel;
    data['oil'] = this.oil;
    if (this.hoobsImage != null) {
      data['hoobsImage'] = this.hoobsImage?.toJson();
    }
    if (this.tachImage != null) {
      data['tachImage'] = this.tachImage?.toJson();
    }
    if (this.fuelImage != null) {
      data['fuelImage'] = this.fuelImage?.toJson();
    }
    if (this.oilImage != null) {
      data['oilImage'] = this.oilImage?.toJson();
    }
    data['description'] = this.description;
    return data;
  }
}