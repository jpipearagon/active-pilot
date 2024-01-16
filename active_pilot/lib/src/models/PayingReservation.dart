class PayingReservation {
  Fees? fees;
  Distribution? distribution;
  String? afv;
  String? iv;
  String? giv;
  String? fiv;
  int? git;
  String? fv;
  String? aircraftFlightValue;
  String? instructionValue;
  String? groundInstructionValue;
  String? flightInstructionValue;
  int? groundInstructionTime;
  String? flightValue;
  int? ft;
  String? id;

  PayingReservation(
      {this.fees,
        this.distribution,
        this.afv,
        this.iv,
        this.giv,
        this.fiv,
        this.git,
        this.fv,
        this.aircraftFlightValue,
        this.instructionValue,
        this.groundInstructionValue,
        this.flightInstructionValue,
        this.groundInstructionTime,
        this.flightValue,
        this.ft,
        this.id});

  PayingReservation.fromJson(Map<String, dynamic> json) {
    fees = json['fees'] != null ? new Fees.fromJson(json['fees']) : null;
    distribution = json['distribution'] != null
        ? new Distribution.fromJson(json['distribution'])
        : null;
    afv = json['afv'];
    iv = json['iv'];
    giv = json['giv'];
    fiv = json['fiv'];
    git = json['git'];
    fv = json['fv'];
    aircraftFlightValue = json['aircraftFlightValue'];
    instructionValue = json['instructionValue'];
    groundInstructionValue = json['groundInstructionValue'];
    flightInstructionValue = json['flightInstructionValue'];
    groundInstructionTime = json['groundInstructionTime'];
    flightValue = json['flightValue'];
    ft = json['ft'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fees != null) {
      data['fees'] = this.fees?.toJson();
    }
    if (this.distribution != null) {
      data['distribution'] = this.distribution?.toJson();
    }
    data['afv'] = this.afv;
    data['iv'] = this.iv;
    data['giv'] = this.giv;
    data['fiv'] = this.fiv;
    data['git'] = this.git;
    data['fv'] = this.fv;
    data['aircraftFlightValue'] = this.aircraftFlightValue;
    data['instructionValue'] = this.instructionValue;
    data['groundInstructionValue'] = this.groundInstructionValue;
    data['flightInstructionValue'] = this.flightInstructionValue;
    data['groundInstructionTime'] = this.groundInstructionTime;
    data['flightValue'] = this.flightValue;
    data['ft'] = this.ft;
    data['id'] = this.id;
    return data;
  }
}

class Fees {
  int? aircraftFee;
  int? instructionFee;

  Fees({this.aircraftFee, this.instructionFee});

  Fees.fromJson(Map<String, dynamic> json) {
    aircraftFee = json['aircraftFee'];
    instructionFee = json['instructionFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aircraftFee'] = this.aircraftFee;
    data['instructionFee'] = this.instructionFee;
    return data;
  }
}

class Distribution {
  Active? active;
  Active? aircraftOwner;
  Active? instructor;

  Distribution({this.active, this.aircraftOwner, this.instructor});

  Distribution.fromJson(Map<String, dynamic> json) {
    active =
    json['active'] != null ? new Active.fromJson(json['active']) : null;
    aircraftOwner = json['aircraftOwner'] != null
        ? new Active.fromJson(json['aircraftOwner'])
        : null;
    instructor = json['instructor'] != null
        ? new Active.fromJson(json['instructor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.active != null) {
      data['active'] = this.active?.toJson();
    }
    if (this.aircraftOwner != null) {
      data['aircraftOwner'] = this.aircraftOwner?.toJson();
    }
    if (this.instructor != null) {
      data['instructor'] = this.instructor?.toJson();
    }
    return data;
  }
}

class Active {
  String? numberDecimal;

  Active({this.numberDecimal});

  Active.fromJson(Map<String, dynamic> json) {
    numberDecimal = json['$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$numberDecimal'] = this.numberDecimal;
    return data;
  }
}