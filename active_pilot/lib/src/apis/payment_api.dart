
import 'package:aircraft/src/models/Pay.dart';
import 'package:aircraft/src/models/ResponseGeneratePayment.dart';

import 'rest_api.dart';

class PaymentApi {

  final RestApi _restApi = RestApi();

  Future<dynamic> generatePayment(String reservationId) async {
    var response;
    try {
      final Map<String, String> params = {
        "reservationId": reservationId,
      };
      response = await _restApi.post(
          endPoint: "/api/payment/", queryParameters: params);
      return ResponseGeneratePayment.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> updateGIT(Map<String, String> fields) async {

    var response;

    try {
      response = await _restApi.patch(endPoint: "/api/paying/git", queryParameters: fields);
      return ResponseGeneratePayment.fromJson(response);;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> goToPay(String reservationId) async {
    var response;
    try {
      final Map<String, String> params = {
        "reservationId": reservationId,
      };
      response = await _restApi.post(
          endPoint: "/api/payment/pay", queryParameters: params);
      return Pay.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> checkPay() async {
    var response;
    try {
      response = await _restApi.get(
          endPoint: "/api/payment/enabled");
      final enabled = response["enabled"] != null? response["enabled"] : false;
      return enabled;
    } catch (e) {
      return e.toString();
    }
  }
}