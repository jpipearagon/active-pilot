class Activity {
    String id;
    bool deleted;
    String name;

    Activity({this.id, this.deleted, this.name});

    factory Activity.fromJson(Map<String, dynamic> json) {
        return Activity(
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