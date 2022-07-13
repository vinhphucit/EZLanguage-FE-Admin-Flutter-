import 'dart:convert';

import 'package:fe_ezlang_admin/models/error_response.dart';
import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/bad_request_exception.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/internal_server_exception.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/unauthorised_exception.dart';
import 'package:fe_ezlang_admin/utils/shared_pref_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseApiService {
  String? _accessToken;

  get accessToken async {
    return await SharedPrefUtils.getAccessToken();
  }

  void updateToken(String? token) {
    _accessToken = token;
  }

  Future<dynamic> get(String url) async {
    final uri = Uri.parse(url);
    var token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token'
      },
    );
    return returnResponse(response);
  }

  Future<dynamic> post(String url, dynamic? body) async {
    final uri = Uri.parse(url);
    var token = await accessToken;
    var rqBody = (body == null ? null : json.encode(body));
    final response = await http.post(uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token'
        },
        body: rqBody);
    return returnResponse(response);
  }

  Future<dynamic> put(String url, dynamic? body) async {
    final uri = Uri.parse(url);
    var token = await accessToken;
    var rqBody = (body == null ? null : json.encode(body));
    final response = await http.put(uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token'
        },
        body: rqBody);
    return returnResponse(response);
  }

  Future<void> delete(String url) async {
    final uri = Uri.parse(url);
    var token = await accessToken;
    final response = await http.delete(
      uri,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token'
      },
    );

    return returnResponse(response);
  }

  dynamic returnResponse(http.Response response) {
    dynamic responseJson;
    if (response.body != null) {
      responseJson = jsonDecode(response.body);
    }
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 204:
        return;
      case 400:
        throw BadRequestException(
            ErrorResponse.fromJson(responseJson).description);
      case 401:
      case 403:
      case 404:
        throw UnauthorisedException(
            ErrorResponse.fromJson(responseJson).description);
      case 500:
      default:
        throw InternalServerException(
            ErrorResponse.fromJson(responseJson).description);
    }
  }
}
