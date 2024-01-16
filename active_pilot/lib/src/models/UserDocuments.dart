
import 'package:aircraft/src/models/UserDetail.dart';

class UserDocuments {
  String? belongsTo;
  String? sId;
  DocumentTemplate? documentTemplate;
  UserPilot? user;
  String? expirationDate;
  List<Files>? files;
  int? iV;

  UserDocuments(
      {this.belongsTo,
        this.sId,
        this.documentTemplate,
        this.user,
        this.expirationDate,
        this.files,
        this.iV});

  UserDocuments.fromJson(Map<String, dynamic> json) {
    belongsTo = json['belongsTo'];
    sId = json['_id'];
    documentTemplate = json['documentTemplate'] != null
        ? new DocumentTemplate.fromJson(json['documentTemplate'])
        : null;
    user = json['user'] != null ? new UserPilot.fromJson(json['documentTemplate'])
        : null ;
    expirationDate = json['expirationDate'];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(new Files.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['belongsTo'] = this.belongsTo;
    data['_id'] = this.sId;
    if (this.documentTemplate != null) {
      data['documentTemplate'] = this.documentTemplate?.toJson();
    }
    data['user'] = this.user;
    data['expirationDate'] = this.expirationDate;
    if (this.files != null) {
      data['files'] = this.files?.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class DocumentTemplate {
  String? sId;
  bool? expires;
  String? title;

  DocumentTemplate({this.sId, this.expires, this.title});

  DocumentTemplate.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    expires = json['expires'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['expires'] = this.expires;
    data['title'] = this.title;
    return data;
  }
}

class Files {
  String? sId;
  String? url;

  Files({this.sId, this.url});

  Files.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['url'] = this.url;
    return data;
  }
}