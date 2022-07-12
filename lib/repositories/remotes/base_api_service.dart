import 'dart:convert';

import 'package:fe_ezlang_admin/models/error_response.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/bad_request_exception.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/internal_server_exception.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/unauthorised_exception.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiService {
  String? accessToken;
  void updateToken(String? token) {
    accessToken = token;
  }

  Future<dynamic> get(String url) async {
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken'
      },
    );
    return returnResponse(response);
  }

  Future<dynamic> post(String url, dynamic? body) async {
    final uri = Uri.parse(url);

    var rqBody = (body == null ? null : json.encode(body));
    final response = await http.post(uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: rqBody);
    return returnResponse(response);
  }

  Future<dynamic> put(String url, dynamic? body) async {
    final uri = Uri.parse(url);

    var rqBody = (body == null ? null : json.encode(body));
    final response = await http.put(uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: rqBody);
    return returnResponse(response);
  }

  Future<void> delete(String url) async {
    final uri = Uri.parse(url);

    final response = await http.delete(
      uri,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
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
            'Error occured while communication with server' +
                ' with status code : ${ErrorResponse.fromJson(responseJson).description}');
    }
  }
}
