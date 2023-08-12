import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_responsebody.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete,
}

class Http {
  Http({
    required Client client,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl;

  final Client _client;
  String _baseUrl;
  void updateBaseUrl(String newBaseUrl) {
    _baseUrl = newBaseUrl;
  }

  Future<Either<HttpFailure, R>> request<R>(
    String path, {
    required R Function(dynamic responseBody) onSuccess,
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, String> body = const {},
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;
    try {
      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl/$path',
      );

      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: queryParameters,
        );
      }
      headers = {
        'Content-Type': 'application/json',
        ...headers,
      };
      late final Response response;
      final bodyString = body.isNotEmpty ? jsonEncode(body) : null;
      logs = {
        'url': url.toString(),
        'method': method.toString(),
        'headers': headers,
        'body': bodyString,
      };

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url, headers: headers);
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
      }

      final statusCode = response.statusCode;
      final responseBody = _parseResponseBody(
        response.body,
      );
      logs = {
        ...logs,
        'startTime': DateTime.now().toIso8601String(),
        'statusCode': response.statusCode,
        'responseBody': responseBody,
      };
      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(
          onSuccess(response.body),
        );
      }
      return Either.left(
        HttpFailure(
          statusCode: statusCode,
        ),
      );
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        'exception': e,
        'stacktrace': s.toString(),
      };
      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': e,
        };
        return Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(
          exception: e.runtimeType.toString(),
        ),
      );
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toIso8601String(),
      };
      _printLogs(logs, stackTrace);
    }
  }
}
