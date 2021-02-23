class UserDetail {
    int v;
    String id;
    Country country;
    String dateBirth;
    bool deleted;
    String email;
    String firstName;
    String gender;
    Instructor instructor;
    bool isAdmin;
    String lastName;
    String phone;
    Photo photo;
    Pilot pilot;
    String role;
    String roles;

    UserDetail({this.v, this.id, this.country, this.dateBirth, this.deleted, this.email, this.firstName, this.gender, this.instructor, this.isAdmin, this.lastName, this.phone, this.photo, this.pilot, this.role, this.roles});

    factory UserDetail.fromJson(Map<String, dynamic> json) {
        return UserDetail(
            v: json['__v'],
            id: json['_id'],
            country: json['country'] != null ? Country.fromJson(json['country']) : null,
            dateBirth: json['dateBirth'],
            deleted: json['deleted'],
            email: json['email'],
            firstName: json['firstName'],
            gender: json['gender'],
            instructor: json['instructor'] != null ? Instructor.fromJson(json['instructor']) : null,
            isAdmin: json['isAdmin'],
            lastName: json['lastName'],
            phone: json['phone'],
            photo: json['photo'] != null ? Photo.fromJson(json['photo']) : null,
            pilot: json['pilot'] != null ? Pilot.fromJson(json['pilot']) : null,
            role: json['role'],
            roles: json['roles'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.v;
        data['_id'] = this.id;
        data['dateBirth'] = this.dateBirth;
        data['deleted'] = this.deleted;
        data['email'] = this.email;
        data['firstName'] = this.firstName;
        data['gender'] = this.gender;
        data['isAdmin'] = this.isAdmin;
        data['lastName'] = this.lastName;
        data['phone'] = this.phone;
        data['role'] = this.role;
        data['roles'] = this.roles;
        if (this.country != null) {
            data['country'] = this.country.toJson();
        }
        if (this.instructor != null) {
            data['instructor'] = this.instructor.toJson();
        }
        if (this.photo != null) {
            data['photo'] = this.photo.toJson();
        }
        if (this.pilot != null) {
            data['pilot'] = this.pilot.toJson();
        }
        return data;
    }
}

class Country {
    String id;
    bool deleted;
    String name;

    Country({this.id, this.deleted, this.name});

    factory Country.fromJson(Map<String, dynamic> json) {
        return Country(
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

class Pilot {
    String id;
    List<String> aircraftCategory;
    bool canFlight;
    bool canReserve;
    String certificateNumber;
    bool enabled;
    bool flyAlone;
    String sId;
    String firstName;
    String lastName;

    Pilot({this.id, this.aircraftCategory, this.canFlight, this.canReserve, this.certificateNumber, this.enabled, this.flyAlone, this.sId, this.firstName, this.lastName});

    factory Pilot.fromJson(Map<String, dynamic> json) {
        return Pilot(
            id: json['_id'],
            aircraftCategory: json['aircraftCategory'] != null ? new List<String>.from(json['aircraftCategory']) : null,
            canFlight: json['canFlight'],
            canReserve: json['canReserve'],
            certificateNumber: json['certificateNumber'],
            enabled: json['enabled'],
            flyAlone: json['flyAlone'],
            sId: json['_id'],
            firstName: json['firstName'],
            lastName: json['lastName']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['canFlight'] = this.canFlight;
        data['canReserve'] = this.canReserve;
        data['certificateNumber'] = this.certificateNumber;
        data['enabled'] = this.enabled;
        data['flyAlone'] = this.flyAlone;
        if (this.aircraftCategory != null) {
            data['aircraftCategory'] = this.aircraftCategory;
        }
        data['_id'] = this.sId;
        data['firstName'] = this.firstName;
        data['lastName'] = this.lastName;
        return data;
    }
}

class Photo {
    String id;
    String bucket;
    String eTag;
    String key;
    String location;
    String url;

    Photo({this.id, this.bucket, this.eTag, this.key, this.location, this.url});

    factory Photo.fromJson(Map<String, dynamic> json) {
        return Photo(
            bucket: json['bucket'],
            eTag: json['eTag'],
            id: json['_id'],
            key: json['key'],
            location: json['location'],
            url: json['url'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bucket'] = this.bucket;
        data['eTag'] = this.eTag;
        data['_id'] = this.id;
        data['key'] = this.key;
        data['location'] = this.location;
        data['url'] = this.url;
        return data;
    }
}

class Instructor {
    String id;
    String description;
    bool enabled;
    Location location;
    String scheduleName;

    Instructor({this.id, this.description, this.enabled, this.location, this.scheduleName});

    factory Instructor.fromJson(Map<String, dynamic> json) {
        return Instructor(
            id: json['_id'],
            description: json['description'],
            enabled: json['enabled'],
            location: json['location'] != null ? Location.fromJson(json['location']) : null,
            scheduleName: json['scheduleName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['description'] = this.description;
        data['enabled'] = this.enabled;
        data['scheduleName'] = this.scheduleName;
        if (this.location != null) {
            data['location'] = this.location.toJson();
        }
        return data;
    }
}

class Location {
    int v;
    String id;
    bool deleted;
    String name;

    Location({this.v, this.id, this.deleted, this.name});

    factory Location.fromJson(Map<String, dynamic> json) {
        return Location(
            v: json['__v'],
            id: json['_id'],
            deleted: json['deleted'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.v;
        data['_id'] = this.id;
        data['deleted'] = this.deleted;
        data['name'] = this.name;
        return data;
    }
}