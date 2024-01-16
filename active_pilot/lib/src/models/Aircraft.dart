import 'UserDetail.dart';

class Aircraft {
    AircraftMaker? aircraftMaker;
    AircraftMaker? aircraftModel;
    List<ActivityType>? activityType;
    String? sId;
    List<AircraftCategories>? aircraftCategories;
    List<Photo>? photos;
    String? registrationTail;
    bool? scheduleable;
    int? year;
    AircraftCategories? location;
    String? name;
    String? id;
    double? hoobs;
    double? tach;
    String? serialNoke;

    Aircraft(
        {this.aircraftMaker,
            this.aircraftModel,
            this.activityType,
            this.sId,
            this.aircraftCategories,
            this.photos,
            this.registrationTail,
            this.scheduleable,
            this.year,
            this.location,
            this.name,
            this.id,
            this.hoobs,
            this.tach,
            this.serialNoke});

    Aircraft.fromJson(Map<String, dynamic> json) {
        aircraftMaker = json['aircraftMaker'] != null
            ? new AircraftMaker.fromJson(json['aircraftMaker'])
            : null;
        aircraftModel = json['aircraftModel'] != null
            ? new AircraftMaker.fromJson(json['aircraftModel'])
            : null;
        if (json['activityType'] != null) {
            activityType = [];
            json['activityType'].forEach((v) {
                if(v is Map<String, dynamic>) {
                    activityType?.add(new ActivityType.fromJson(v));
                }
            });
        }
        sId = json['_id'];
        if (json['aircraftCategories'] != null) {
            aircraftCategories = [];
            json['aircraftCategories'].forEach((v) {
                aircraftCategories?.add(new AircraftCategories.fromJson(v));
            });
        }
        if (json['photos'] != null) {
            photos = [];
            json['photos'].forEach((v) {
                photos?.add(new Photo.fromJson(v));
            });
        }
        registrationTail = json['registrationTail'];
        scheduleable = json['scheduleable'];
        year = json['year'];
        location = json['location'] != null
            ? new AircraftCategories.fromJson(json['location'])
            : null;
        name = json['name'];
        id = json['id'];
        hoobs = json['hoobs'].toDouble();
        tach = json['tach'].toDouble();
        serialNoke = json['nokeSN'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.aircraftMaker != null) {
            data['aircraftMaker'] = this.aircraftMaker?.toJson();
        }
        final aircraftModel = this.aircraftModel;
        if (aircraftModel != null) {
            data['aircraftModel'] = aircraftModel.toJson();
        }
        if (this.activityType != null) {
            data['activityType'] = this.activityType?.map((v) => v.toJson()).toList();
        }
        data['_id'] = this.sId;
        if (this.aircraftCategories != null) {
            data['aircraftCategories'] =
                this.aircraftCategories?.map((v) => v.toJson()).toList();
        }
        if (this.photos != null) {
            data['photos'] = this.photos?.map((v) => v.toJson()).toList();
        }
        data['registrationTail'] = this.registrationTail;
        data['scheduleable'] = this.scheduleable;
        data['year'] = this.year;
        if (this.location != null) {
            data['location'] = this.location?.toJson();
        }
        data['name'] = this.name;
        data['id'] = this.id;
        data['hoobs'] = this.hoobs;
        data['tach'] = this.tach;
        data['nokeSN'] = this.serialNoke;
        return data;
    }
}

class AircraftCategories {
    bool? deleted;
    String? sId;
    String? name;
    int? iV;

    AircraftCategories({this.deleted, this.sId, this.name, this.iV});

    AircraftCategories.fromJson(Map<String, dynamic> json) {
        deleted = json['deleted'];
        sId = json['_id'];
        name = json['name'];
        iV = json['__v'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['deleted'] = this.deleted;
        data['_id'] = this.sId;
        data['name'] = this.name;
        data['__v'] = this.iV;
        return data;
    }
}

class AircraftMaker {
    String? sId;
    bool? deleted;
    String? name;

    AircraftMaker({this.sId, this.deleted, this.name});

    AircraftMaker.fromJson(Map<String, dynamic> json) {
        sId = json['_id'];
        deleted = json['deleted'];
        name = json['name'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.sId;
        data['deleted'] = this.deleted;
        data['name'] = this.name;
        return data;
    }
}

class ActivityType {
    bool? deleted;
    String? sId;
    String? name;

    ActivityType({this.deleted, this.sId, this.name});

    ActivityType.fromJson(Map<String, dynamic> json) {
        deleted = json['deleted'];
        sId = json['_id'];
        name = json['name'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['deleted'] = this.deleted;
        data['_id'] = this.sId;
        data['name'] = this.name;
        return data;
    }
}