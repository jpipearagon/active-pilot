class Reservation {
  int tag;
  String startDate;
  String endDate;
  String event;
  String eventType;

  Reservation(
    this.tag,
    this.startDate,
    this.endDate,
    this.event,
    this.eventType,
  );

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return null;
  }
}
