import 'UserDetail.dart';

class Aircraft {
    List<AircraftCategory> aircraftCategory;
    List<ActivityType> activityType;
    String sId;
    List<Photo> photos;
    String registrationTail;
    int year;
    ActivityType aircraftMaker;
    ActivityType aircraftModel;
    bool scheduleable;
    AircraftCategory location;
    String name;
    String id;

    Aircraft(
        {this.aircraftCategory,
            this.activityType,
            this.sId,
            this.photos,
            this.registrationTail,
            this.year,
            this.aircraftMaker,
            this.aircraftModel,
            this.scheduleable,
            this.location,
            this.name,
            this.id});

    Aircraft.fromJson(Map<String, dynamic> json) {
        if (json['aircraftCategory'] != null) {
            aircraftCategory = new List<AircraftCategory>();
            json['aircraftCategory'].forEach((v) {
                aircraftCategory.add(new AircraftCategory.fromJson(v));
            });
        }
        if (json['activityType'] != null) {
            activityType = new List<ActivityType>();
            json['activityType'].forEach((v) {
                activityType.add(new ActivityType.fromJson(v));
            });
        }
        sId = json['_id'];
        if (json['photos'] != null) {
            photos = new List<Photo>();
            json['photos'].forEach((v) {
                photos.add(new Photo.fromJson(v));
            });
        }
        registrationTail = json['registrationTail'];
        year = json['year'];
        aircraftMaker = json['aircraftMaker'] != null
            ? new ActivityType.fromJson(json['aircraftMaker'])
            : null;
        aircraftModel = json['aircraftModel'] != null
            ? new ActivityType.fromJson(json['aircraftModel'])
            : null;
        scheduleable = json['scheduleable'];
        location = json['location'] != null
            ? new AircraftCategory.fromJson(json['location'])
            : null;
        name = json['name'];
        id = json['id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.aircraftCategory != null) {
            data['aircraftCategory'] =
                this.aircraftCategory.map((v) => v.toJson()).toList();
        }
        if (this.activityType != null) {
            data['activityType'] = this.activityType.map((v) => v.toJson()).toList();
        }
        data['_id'] = this.sId;
        if (this.photos != null) {
            data['photos'] = this.photos.map((v) => v.toJson()).toList();
        }
        data['registrationTail'] = this.registrationTail;
        data['year'] = this.year;
        if (this.aircraftMaker != null) {
            data['aircraftMaker'] = this.aircraftMaker.toJson();
        }
        if (this.aircraftModel != null) {
            data['aircraftModel'] = this.aircraftModel.toJson();
        }
        data['scheduleable'] = this.scheduleable;
        if (this.location != null) {
            data['location'] = this.location.toJson();
        }
        data['name'] = this.name;
        data['id'] = this.id;
        return data;
    }
}

class AircraftCategory {
    bool deleted;
    String sId;
    String name;
    int iV;

    AircraftCategory({this.deleted, this.sId, this.name, this.iV});

    AircraftCategory.fromJson(Map<String, dynamic> json) {
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

class ActivityType {
    bool deleted;
    String sId;
    String name;

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