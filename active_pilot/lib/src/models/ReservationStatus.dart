class ReservationStatus {
  String id;
  String name;
  String color;

  ReservationStatus({
    this.id,
    this.name,
    this.color,
  });

  factory ReservationStatus.fromJson(Map<String, dynamic> json) {
    return ReservationStatus(
      id: json['_id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
