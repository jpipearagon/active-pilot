import 'package:aircraft/src/models/CodeError.dart';
import 'package:aircraft/src/models/LoginUser.dart';
import 'package:aircraft/src/sharedpreferences/shared_preferences_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:aircraft/src/exceptions/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class RestApi {
  final String _baseUrl = "api-dev.activepilot.com";

  Future<dynamic> get({ @required String endPoint, Map<String, String> queryParameters}) async {
    var responseJson;
    try {
      final url = Uri.https(_baseUrl, endPoint, queryParameters);
      final Map<String, String> headers = {
        HttpHeaders.userAgentHeader: "CFNetwork/1121.2.1 Darwin/19.3.0",
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
      };
      final prefs = SharedPreferencesUser();
      if(prefs.jwtToken.isNotEmpty) {
        headers[HttpHeaders.authorizationHeader] = "bearer " + prefs.jwtToken;
      }
      final response = await http.get(url, headers: headers).timeout(const Duration(seconds: 60));
      responseJson = _response(response);
    } on TimeoutException  {
      throw FetchDataException('Timeout connection');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      await refreshToken();
      responseJson = await get(endPoint: endPoint, queryParameters: queryParameters);
    }
    return responseJson;
  }

  Future<dynamic> post({ @required String endPoint, Map<String, dynamic> queryParameters}) async {
    var responseJson;
    try {
      final url = Uri.https(_baseUrl, endPoint);
      final body = Transformer.urlEncodeMap(queryParameters);
      final Map<String, String> headers = {
        HttpHeaders.userAgentHeader: "CFNetwork/1121.2.1 Darwin/19.3.0",
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
      };
      final prefs = SharedPreferencesUser();
      if(prefs.jwtToken.isNotEmpty) {
        headers[HttpHeaders.authorizationHeader] = "bearer " + prefs.jwtToken;
      }
      final response = await http.post(url, headers: headers,
          body: queryParameters).timeout(const Duration(seconds: 60));
      responseJson = _response(response);
    } on TimeoutException  {
      throw FetchDataException('Timeout connection');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      await refreshToken();
      responseJson = await post(endPoint: endPoint, queryParameters: queryParameters);
    }
    return responseJson;
  }

  Future<dynamic> refreshToken() async {
    var responseJson;
    try {
      final prefs = SharedPreferencesUser();
      final url = Uri.https(_baseUrl, "/token/refreshToken");
      final Map<String, String> params = {
        "refreshToken": prefs.refreshToken,
      };
      final response = await http.post(url, headers: {
        HttpHeaders.userAgentHeader: "CFNetwork/1121.2.1 Darwin/19.3.0",
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      }, body: params).timeout(const Duration(seconds: 60));
      responseJson = _response(response);
      final user = LoginUser.fromJson(responseJson);
      prefs.jwtToken = user.jwtToken;
      prefs.refreshToken = user.refreshToken;
    } on TimeoutException  {
      throw FetchDataException('Timeout connection');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {

    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        final responseJson = json.decode(response.body.toString());
        final codeError = CodeError.fromJson(responseJson);
        throw InternalServerException(codeError.message);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}