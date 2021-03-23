
import 'Activities.dart';
import 'Aircraft.dart';
import 'UserDetail.dart';

class Reservation {
  bool approved;
  bool deleted;
  String sId;
  String start;
  String end;
  Aircraft aircraft;
  Instructor instructor;
  Pilot pilot;
  Activity activity;
  Status status;
  int iV;

  Reservation(
      {this.approved,
        this.deleted,
        this.sId,
        this.start,
        this.end,
        this.aircraft,
        this.instructor,
        this.pilot,
        this.activity,
        this.status,
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
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    pilot = json['pilot'] != null ? new Pilot.fromJson(json['pilot']) : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
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
      data['aircraft'] = this.aircraft.toJson();
    }
    if (this.instructor != null) {
      data['instructor'] = this.instructor.toJson();
    }
    if (this.pilot != null) {
      data['pilot'] = this.pilot.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Status {
  String sId;
  String name;
  String color;

  Status({this.sId, this.name, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
