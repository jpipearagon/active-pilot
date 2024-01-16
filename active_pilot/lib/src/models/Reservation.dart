
import 'Activities.dart';
import 'Aircraft.dart';
import 'PayingReservation.dart';
import 'UserDetail.dart';

class Reservation {
  bool? approved;
  bool? deleted;
  String? sId;
  String? start;
  String? end;
  Aircraft? aircraft;
  UserInstructor? userInstructor;
  UserPilot? userPilot;
  Activity? activity;
  Status? status;
  PayingReservation? paying;
  int? iV;

  Reservation(
      {this.approved,
        this.deleted,
        this.sId,
        this.start,
        this.end,
        this.aircraft,
        this.userInstructor,
        this.userPilot,
        this.activity,
        this.status,
        this.paying,
        this.iV});

  Reservation.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    deleted = json['deleted'];
    sId = json['_id'];
    start = json['start'];
    end = json['end'];
    aircraft = json['aircraft'] != null
        ? new Aircraft.fromJson(json['aircraft'])
        : null;
    userInstructor = json['userInstructor'] != null
        ? new UserInstructor.fromJson(json['userInstructor'])
        : null;
    userPilot = json['userPilot'] != null
        ? new UserPilot.fromJson(json['userPilot'])
        : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    paying = json['paying'] != null
        ? new PayingReservation.fromJson(json['paying'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approved'] = this.approved;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['start'] = this.start;
    data['end'] = this.end;
    if (this.aircraft != null) {
      data['aircraft'] = this.aircraft?.toJson();
    }
    if (this.userInstructor != null) {
      data['userInstructor'] = this.userInstructor?.toJson();
    }
    if (this.userPilot != null) {
      data['userPilot'] = this.userPilot?.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity?.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status?.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Status {
  String? sId;
  String? name;
  String? color;

  Status({this.sId, this.name, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] != null ? json['_id'] : "";
    name = json['name'] != null ? json['name'] : "" ;
    color = json['color'] != null ? json['color'] : "#000000";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}