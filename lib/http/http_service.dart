import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:random_jokes_assessment/exceptions/app_exceptions.dart';
import 'package:random_jokes_assessment/interceptors/http_interceptor.dart';

class HttpService {
  http.Client client = HttpClientWithInterceptor.build(
    interceptors: [
      HttpInterceptor(),
    ],
    requestTimeout: const Duration(milliseconds: 24000),
  );

  Future<dynamic> delete(String route, dynamic body, dynamic headers) async {
    try {
      final url = Uri.parse(route);
      // log.i('HTTP DELETE $url with ${jsonEncode(body)}');
      final response = await client.delete(url, body: jsonEncode(body), headers: headers);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection 😑');
    } on FormatException {
      throw FetchDataException('Bad response format 👎');
    }
  }

  Future<dynamic> get(String route) async {
    try {
      final url = Uri.parse(route);
      final response = await client.get(url);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection 😑');
    } on TimeoutException {
      throw FetchDataException('Connection timed out 😑');
    } on FormatException {
      throw FetchDataException('Bad response format 👎');
    }
  }

  Future<dynamic> post({required String route, dynamic body, dynamic headers}) async {
    try {
      final url = Uri.parse(route);
      final response = await client.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      return _processResponse(response);
    } on FormatException {
      throw FetchDataException('Bad response format 👎');
    } on TimeoutException {
      throw FetchDataException('Connection timed out 😑');
    }
  }

  dynamic _processResponse(http.Response response) {
    final jsonBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonBody;
      case 400:
        throw ApiException(jsonBody['message'].toString());
      case 401:
      case 403:
        throw ApiException(jsonBody['message'].toString());
      case 500:
      default:
        throw FetchDataException('Error occurred while communicating with the server with StatusCode: ${response.statusCode}');
    }
  }
}
