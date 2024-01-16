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