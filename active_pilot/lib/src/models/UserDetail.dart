import 'package:aircraft/src/models/Aircraft.dart';

class UserDetail {
    int? v;
    String? id;
    Country? country;
    String? dateBirth;
    bool? deleted;
    String? email;
    String? firstName;
    String? gender;
    Instructor? instructor;
    bool? isAdmin;
    String? lastName;
    String? phone;
    Photo? photo;
    Pilot? pilot;
    String? roleStr;
    List<String>? roles;
    String? city;
    String? address;
    String? address2;
    String? state;
    String? zip;

    UserDetail({this.v, this.id, this.country, this.dateBirth, this.deleted, this.email, this.firstName, this.gender, this.instructor, this.isAdmin, this.lastName, this.phone, this.photo, this.pilot, this.roleStr, this.roles, this.city, this.address, this.address2, this.state, this.zip});

    factory UserDetail.fromJson(Map<String, dynamic> json) {

        List<String> tempRoles = [];
        if (json['roles'] != null) {
            tempRoles = [];
            json['roles'].forEach((v) {
                if(v is String) {
                    tempRoles.add(v);
                }
            });
        }

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
            roleStr: json['roleStr'],
            city: json['city'],
            address: json['address'],
            address2: json['address2'],
            state: json['state'],
            zip: json['zip'],
            roles: tempRoles,
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
        data['roleStr'] = this.roleStr;
        data['roles'] = this.roles;
        data['city'] = this.city;
        data['address'] = this.address;
        data['address2'] = this.address2;
        data['state'] = this.state;
        data['zip'] = this.zip;
        if (this.country != null) {
            data['country'] = this.country?.toJson();
        }
        if (this.instructor != null) {
            data['instructor'] = this.instructor?.toJson();
        }
        if (this.photo != null) {
            data['photo'] = this.photo?.toJson();
        }
        if (this.pilot != null) {
            data['pilot'] = this.pilot?.toJson();
        }
        return data;
    }

    static UserDetail none(String id) {
        return UserDetail(v: 0,
        id: id,
        country: null,
        dateBirth: "",
        deleted: false,
        email: "",
        firstName: "none",
        gender: "",
        instructor: null,
        isAdmin: false,
        lastName: "",
        phone: "",
        photo: null,
        pilot: null,
        roleStr: "",
        city: "",
        address: "",
        address2: "",
        state: "",
        zip: "",
        roles: []);
    }
}

class Country {
    String? id;
    bool? deleted;
    String? name;

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


class Photo {
    String? id;
    String? bucket;
    String? eTag;
    String? key;
    String? location;
    String? url;

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

class UserInstructor {
    Instructor? instructor;
    String? sId;

    UserInstructor({this.instructor, this.sId});

    UserInstructor.fromJson(Map<String, dynamic> json) {
        instructor = json['instructor'] != null
            ? new Instructor.fromJson(json['instructor'])
            : null;
        sId = json['_id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.instructor != null) {
            data['instructor'] = this.instructor?.toJson();
        }
        data['_id'] = this.sId;
        return data;
    }
}

class Instructor {
    bool? enabled;
    String? scheduleName;
    String? description;
    String? giv;
    String? fiv;
    AircraftCategories? location;

    Instructor(
        {this.enabled, this.scheduleName, this.description, this.location, this.giv, this.fiv});

    Instructor.fromJson(Map<String, dynamic> json) {
        enabled = json['enabled'];
        scheduleName = json['scheduleName'];
        description = json['description'];
        giv = json['giv'];
        fiv = json['fiv'];
        location = json['location'] != null
            ? new AircraftCategories.fromJson(json['location'])
            : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['enabled'] = this.enabled;
        data['scheduleName'] = this.scheduleName;
        data['description'] = this.description;
        data['giv'] = this.giv;
        data['fiv'] = this.fiv;
        if (this.location != null) {
            data['location'] = this.location?.toJson();
        }
        return data;
    }
}

class UserPilot {
    Pilot? pilot;
    String? sId;
    String? firstName;
    String? lastName;
    String? fullName;
    String? id;

    UserPilot(
        {this.pilot,
            this.sId,
            this.firstName,
            this.lastName,
            this.fullName,
            this.id});

    UserPilot.fromJson(Map<String, dynamic> json) {
        pilot = json['pilot'] != null ? new Pilot.fromJson(json['pilot']) : null;
        sId = json['_id'];
        firstName = json['firstName'];
        lastName = json['lastName'];
        fullName = json['fullName'];
        id = json['id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.pilot != null) {
            data['pilot'] = this.pilot?.toJson();
        }
        data['_id'] = this.sId;
        data['firstName'] = this.firstName;
        data['lastName'] = this.lastName;
        data['fullName'] = this.fullName;
        data['id'] = this.id;
        return data;
    }
}

class Pilot {
    bool? enabled;
    List<String>? aircraftCategories;
    String? certificateNumber;
    bool? canFlight;
    bool? flyAlone;
    bool? canReserve;

    Pilot(
        {this.enabled,
            this.aircraftCategories,
            this.certificateNumber,
            this.canFlight,
            this.flyAlone,
            this.canReserve});

    Pilot.fromJson(Map<String, dynamic> json) {
        enabled = json['enabled'];
        if (json['aircraftCategories'] != null) {
            aircraftCategories = [];
            json['aircraftCategories'].forEach((v) {
                if(v is String) {
                    aircraftCategories?.add(v);
                }
            });
        }
        certificateNumber = json['certificateNumber'];
        canFlight = json['canFlight'];
        flyAlone = json['flyAlone'];
        canReserve = json['canReserve'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['enabled'] = this.enabled;
        data['aircraftCategories'] = this.aircraftCategories;
        data['certificateNumber'] = this.certificateNumber;
        data['canFlight'] = this.canFlight;
        data['flyAlone'] = this.flyAlone;
        data['canReserve'] = this.canReserve;
        return data;
    }
}

class Location {
    int? v;
    String? id;
    bool? deleted;
    String? name;

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