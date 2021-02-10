import 'UserDetail.dart';

class Aircraft {
    int v;
    String id;
    List<String> activityType;
    List<String> aircraftCategory;
    AircraftMaker aircraftMaker;
    AircraftModel aircraftModel;
    bool deleted;
    Location location;
    List<Photo> photos;
    String registrationTail;
    bool scheduleable;
    int year;

    Aircraft({this.v, this.id, this.activityType, this.aircraftCategory, this.aircraftMaker, this.aircraftModel, this.deleted, this.location, this.photos, this.registrationTail, this.scheduleable, this.year});

    factory Aircraft.fromJson(Map<String, dynamic> json) {
        return Aircraft(
            v: json['__v'],
            id: json['_id'],
            activityType: json['activityType'] != null ? new List<String>.from(json['activityType']) : null,
            aircraftCategory: json['aircraftCategory'] != null ? new List<String>.from(json['aircraftCategory']) : null,
            aircraftMaker: json['aircraftMaker'] != null ? AircraftMaker.fromJson(json['aircraftMaker']) : null,
            aircraftModel: json['aircraftModel'] != null ? AircraftModel.fromJson(json['aircraftModel']) : null,
            deleted: json['deleted'],
            location: json['location'] != null ? Location.fromJson(json['location']) : null,
            photos: json['photos'] != null ? (json['photos'] as List).map((i) => Photo.fromJson(i)).toList() : null,
            registrationTail: json['registrationTail'],
            scheduleable: json['scheduleable'],
            year: json['year'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.v;
        data['_id'] = this.id;
        data['deleted'] = this.deleted;
        data['registrationTail'] = this.registrationTail;
        data['scheduleable'] = this.scheduleable;
        data['year'] = this.year;
        if (this.activityType != null) {
            data['activityType'] = this.activityType;
        }
        if (this.aircraftCategory != null) {
            data['aircraftCategory'] = this.aircraftCategory;
        }
        if (this.aircraftMaker != null) {
            data['aircraftMaker'] = this.aircraftMaker.toJson();
        }
        if (this.aircraftModel != null) {
            data['aircraftModel'] = this.aircraftModel.toJson();
        }
        if (this.location != null) {
            data['location'] = this.location.toJson();
        }
        if (this.photos != null) {
            data['photos'] = this.photos.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class AircraftMaker {
    String id;
    bool deleted;
    String name;

    AircraftMaker({this.id, this.deleted, this.name});

    factory AircraftMaker.fromJson(Map<String, dynamic> json) {
        return AircraftMaker(
            id: json['_id'],
            deleted: json['deleted'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['deleted'] = this.deleted;
        data['name'] = this.name;
        return data;
    }
}

class AircraftModel {
    String id;
    bool deleted;
    String name;

    AircraftModel({this.id, this.deleted, this.name});

    factory AircraftModel.fromJson(Map<String, dynamic> json) {
        return AircraftModel(
            id: json['_id'],
            deleted: json['deleted'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['deleted'] = this.deleted;
        data['name'] = this.name;
        return data;
    }
}