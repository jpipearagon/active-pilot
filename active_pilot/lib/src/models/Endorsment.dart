class Endorsment {
  final String id;
  final String expirationDate;
  final String issuedDate;
  final String description;
  final String title;

  Endorsment({
    this.id,
    this.expirationDate,
    this.issuedDate,
    this.description,
    this.title,
  });

  factory Endorsment.fromJson(Map<String, dynamic> json) {
    return Endorsment(
      id: json['_id'],
      expirationDate: json['expirationDate'],
      issuedDate: json['issuedDate'],
      description: json["value"],
      title: json['endorsementTemplate']['title'],
    );
  }
}
