class ProfileCountry {
  bool? deleted;
  String? sId;
  String? name;

  ProfileCountry({this.deleted, this.sId, this.name});

  ProfileCountry.fromJson(Map<String, dynamic> json) {
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