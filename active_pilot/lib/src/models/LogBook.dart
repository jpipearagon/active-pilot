import 'Activities.dart';
import 'Aircraft.dart';
import 'UserDetail.dart';

class LogBook {
  String? sId;
  int? iV;
  Activity? activity;
  Aircraft? aircraft;
  String? creationDate;
  double? hoobs;
  UserInstructor? instructor;
  UserPilot? pilot;
  String? reservation;
  double? tach;
  String? adCfi;
  int? approaches;
  String? crossCountry;
  String? dual;
  String? from;
  int? holdings;
  String? ifr;
  String? ifrActual;
  int? landings;
  int? night;
  String? pic;
  String? solo;
  String? to;
  int? toDay;
  int? toNight;
  int? git;

  LogBook(
      {this.sId,
        this.iV,
        this.activity,
        this.aircraft,
        this.creationDate,
        this.hoobs,
        this.instructor,
        this.pilot,
        this.reservation,
        this.tach,
        this.adCfi,
        this.approaches,
        this.crossCountry,
        this.dual,
        this.from,
        this.holdings,
        this.ifr,
        this.ifrActual,
        this.landings,
        this.night,
        this.pic,
        this.solo,
        this.to,
        this.toDay,
        this.toNight,
        this.git});

  LogBook.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    iV = json['__v'];
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    aircraft = json['aircraft'] != null
        ? new Aircraft.fromJson(json['aircraft'])
        : null;
    creationDate = json['creationDate'];
    hoobs = double.parse(json['hoobs'].toString());
    instructor = json['instructor'] != null
        ? new UserInstructor.fromJson(json['instructor'])
        : null;
    pilot = json['pilot'] != null ? new UserPilot.fromJson(json['pilot']) : null;
    reservation = json['reservation'];
    tach = double.parse(json['tach'].toString());
    adCfi = json['adCfi'];
    approaches = json['approaches'];
    crossCountry = json['crossCountry'];
    dual = json['dual'];
    from = json['from'];
    holdings = json['holdings'];
    ifr = json['ifr'];
    ifrActual = json['ifrActual'];
    landings = json['landings'];
    night = json['night'];
    pic = json['pic'];
    solo = json['solo'];
    to = json['to'];
    toDay = json['toDay'];
    toNight = json['toNight'];
    git = json['git'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    if (this.activity != null) {
      data['activity'] = this.activity?.toJson();
    }
    if (this.aircraft != null) {
      data['aircraft'] = this.aircraft?.toJson();
    }
    data['creationDate'] = this.creationDate;
    data['hoobs'] = this.hoobs;
    if (this.instructor != null) {
      data['instructor'] = this.instructor?.toJson();
    }
    if (this.pilot != null) {
      data['pilot'] = this.pilot?.toJson();
    }
    data['reservation'] = this.reservation;
    data['tach'] = this.tach;
    data['adCfi'] = this.adCfi;
    data['approaches'] = this.approaches;
    data['crossCountry'] = this.crossCountry;
    data['dual'] = this.dual;
    data['from'] = this.from;
    data['holdings'] = this.holdings;
    data['ifr'] = this.ifr;
    data['ifrActual'] = this.ifrActual;
    data['landings'] = this.landings;
    data['night'] = this.night;
    data['pic'] = this.pic;
    data['solo'] = this.solo;
    data['to'] = this.to;
    data['toDay'] = this.toDay;
    data['toNight'] = this.toNight;
    data['git'] = this.git;
    return data;
  }
}