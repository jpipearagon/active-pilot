class UserTotals {
  double? totalDays;
  double? last30Days;
  double? last90Days;
  double? approaches;

  UserTotals(
      {this.totalDays, this.last30Days, this.last90Days, this.approaches});

  UserTotals.fromJson(Map<String, dynamic> json) {
    totalDays = double.parse(json['totalDays'].toString());
    last30Days = double.parse(json['last30Days'].toString());
    last90Days = double.parse(json['last90Days'].toString());
    approaches = double.parse(json['approaches'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDays'] = this.totalDays;
    data['last30Days'] = this.last30Days;
    data['last90Days'] = this.last90Days;
    data['approaches'] = this.approaches;
    return data;
  }
}