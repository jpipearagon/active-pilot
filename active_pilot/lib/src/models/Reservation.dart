
import 'Activities.dart';
import 'UserDetail.dart';

class Reservation {
  bool approved;
  String sId;
  bool deleted;
  String start;
  String end;
  Status status;
  int iV;
  Pilot pilot;
  Activity activity;

  Reservation(
      {this.approved,
        this.sId,
        this.deleted,
        this.start,
        this.end,
        this.status,
        this.iV,
        this.pilot,
        this.activity
      });

  Reservation.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    sId = json['_id'];
    deleted = json['deleted'];
    start = json['start'];
    end = json['end'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    iV = json['__v'];
    pilot = json['pilot'] != null ? new Pilot.fromJson(json['pilot']) : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approved'] = this.approved;
    data['_id'] = this.sId;
    data['deleted'] = this.deleted;
    data['start'] = this.start;
    data['end'] = this.end;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['__v'] = this.iV;
    if (this.pilot != null) {
      data['pilot'] = this.pilot.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
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
