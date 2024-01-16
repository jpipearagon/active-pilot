class AircraftDocumentDetail {
  String? sId;
  String? expirationDate;
  String? name;
  bool? expires;
  List<String>? files;
  bool? expired;

  AircraftDocumentDetail(
      {this.sId,
        this.expirationDate,
        this.name,
        this.expires,
        this.files,
        this.expired});

  AircraftDocumentDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] != null ? json['_id'] : "";
    expirationDate = json['expirationDate'] != null ? json['expirationDate'] : "";
    name = json['name'] != null ? json['name'] : "";
    expires = json['expires'] != null ? json['expires'] : false;
    files = json['files'] != null ? json['files'].cast<String>() : [];
    expired = json['expired'] != null ? json['expired'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['expirationDate'] = this.expirationDate;
    data['name'] = this.name;
    data['expires'] = this.expires;
    data['files'] = this.files;
    data['expired'] = this.expired;
    return data;
  }
}