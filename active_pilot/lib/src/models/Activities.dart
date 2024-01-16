class Activity {
    String id;
    String name;

    Activity({required this.id, required this.name});

    factory Activity.fromJson(Map<String, dynamic> json) {
        return Activity(
            id: json['_id'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['name'] = this.name;
        return data;
    }
}