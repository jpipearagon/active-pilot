
class Reservation {
  bool approved;
  String sId;
  bool deleted;
  String start;
  String end;
  Status status;
  int iV;

  Reservation(
      {this.approved,
        this.sId,
        this.deleted,
        this.start,
        this.end,
        this.status,
        this.iV});

  Reservation.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    sId = json['_id'];
    deleted = json['deleted'];
    start = json['start'];
    end = json['end'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    iV = json['__v'];
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
