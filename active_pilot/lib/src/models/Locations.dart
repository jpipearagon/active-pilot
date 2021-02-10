
class LocationUser {
    int v;
    String id;
    bool deleted;
    String name;

    LocationUser({this.v, this.id, this.deleted, this.name});

    factory LocationUser.fromJson(Map<String, dynamic> json) {
        return LocationUser(
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