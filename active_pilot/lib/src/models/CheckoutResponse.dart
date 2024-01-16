class CheckoutResponse {
  String? sId;
  Checkout? checkout;
  int? iV;

  CheckoutResponse({this.sId, this.checkout, this.iV});

  CheckoutResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    checkout = json['checkout'] != null
        ? new Checkout.fromJson(json['checkout'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.checkout != null) {
      data['checkout'] = this.checkout?.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Checkout {
  List<ResponseImages>? discrepancyImages;
  double? hoobs;
  double? tach;
  ResponseImages? hoobsImage;
  ResponseImages? tachImage;
  String? description;

  Checkout(
      {this.discrepancyImages,
        this.hoobs,
        this.tach,
        this.hoobsImage,
        this.tachImage,
        this.description});

  Checkout.fromJson(Map<String, dynamic> json) {
    if (json['discrepancyImages'] != null) {
      discrepancyImages = [];
      json['discrepancyImages'].forEach((v) {
        discrepancyImages?.add(new ResponseImages.fromJson(v));
      });
    }
    hoobs = json['hoobs'].toDouble();
    tach = json['tach'].toDouble();
    hoobsImage = json['hoobsImage'] != null
        ? new ResponseImages.fromJson(json['hoobsImage'])
        : null;
    tachImage = json['tachImage'] != null
        ? new ResponseImages.fromJson(json['tachImage'])
        : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discrepancyImages != null) {
      data['discrepancyImages'] =
          this.discrepancyImages?.map((v) => v.toJson()).toList();
    }
    data['hoobs'] = this.hoobs;
    data['tach'] = this.tach;
    if (this.hoobsImage != null) {
      data['hoobsImage'] = this.hoobsImage?.toJson();
    }
    if (this.tachImage != null) {
      data['tachImage'] = this.tachImage?.toJson();
    }
    data['description'] = this.description;
    return data;
  }
}

class ResponseImages {
  String? sId;
  String? url;

  ResponseImages({this.sId, this.url});

  ResponseImages.fromJson(Map<String, dynamic> json) {
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