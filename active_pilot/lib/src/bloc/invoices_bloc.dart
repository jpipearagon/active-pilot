
import 'dart:async';

import 'package:aircraft/src/apis/invoice_api.dart';
import 'package:aircraft/src/apis/user_detail_api.dart';
import 'package:aircraft/src/models/Invoice.dart';
import 'package:aircraft/src/models/LogBook.dart';
import 'package:aircraft/src/models/Reservation.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';

class InvoicesBloc {
  static final InvoicesBloc _singleton = InvoicesBloc._internal();

  InvoicesBloc._internal();

  // ignore: close_sinks
  final _invoiceStreamController =
  StreamController<dynamic>.broadcast();
  Function(dynamic) get invoiceSink =>
      _invoiceStreamController.sink.add;
  Stream<dynamic> get invoiceStream =>
      _invoiceStreamController.stream;

  // ignore: close_sinks
  final _reservationStreamController =
  StreamController<dynamic>.broadcast();
  Function(dynamic) get reservationSink =>
      _reservationStreamController.sink.add;
  Stream<dynamic> get reservationStream =>
      _reservationStreamController.stream;

  factory InvoicesBloc() {
    return _singleton;
  }

  Future<void> loadInvoice() async {
    final invoiceApi = InvoiceApi();

    final response = await invoiceApi.getInvoice();
    invoiceSink(response);

    return null;
  }

  Future<void> loadRservation() async {
    final invoiceApi = InvoiceApi();

    final response = await invoiceApi.getReservationReadyToPay();
    reservationSink(response);

    return null;
  }
}
