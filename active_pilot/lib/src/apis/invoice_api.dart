
import 'package:aircraft/src/models/Invoice.dart';
import 'package:aircraft/src/models/Reservation.dart';

import 'rest_api.dart';

class InvoiceApi {
  final RestApi _restApi = RestApi();

  Future<dynamic> getReservationReadyToPay() async {
    try {
      List<dynamic> response = await _restApi.get(
          endPoint: '/api/reservations/readyToPay');
      final list = response.map((data) {
        return Reservation.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getInvoice() async {
    try {
      List<dynamic> response = await _restApi.get(
          endPoint: '/api/invoices');
      final list = response.map((data) {
        return Invoice.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      return e.toString();
    }
  }
}