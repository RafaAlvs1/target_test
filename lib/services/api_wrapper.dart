import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:target_test/services/authentication.dart';

export 'package:dio/dio.dart';


const String BASE_URL = 'https://654f2e65358230d8f0cd1735.mockapi.io/';
int _timeout = 15000;

class ApiWrapper {
  static Dio create({
    int? timeout,
    String? baseUrl,
  }) {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: Duration(milliseconds: timeout ?? _timeout),
        receiveTimeout: Duration(milliseconds: timeout ?? _timeout),
        baseUrl: BASE_URL,
      ),
    );

    dio.interceptors.add(AppInterceptors(
      dio: dio,
    ));

    return dio;
  }
}


class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors({
    required this.dio,
  });

  @override
  onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {

    final secrets = Authentication().getSecretToken();
    if(secrets?.isNotEmpty ?? false) {
      options.headers['Authorization'] = secrets;
    }

    return handler.next(options);
  }

  @override
  onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    _debugPrint(response);
    return handler.next(response);
  }

  void _debugPrint(
      Response? response, [
        bool error = false,
      ]) {
    if (response == null) {
      return;
    }
    String result = '${response.requestOptions.method}:'
        '${response.statusCode} '
        '${error ? ': ERROR' : ''} '
        ':::'
        ' ${response.requestOptions.baseUrl}'
        '${response.requestOptions.path}'
        '${response.requestOptions.method == 'GET' ? '' : '\n${jsonEncode(response.requestOptions.data ?? {})}'}'
        '${_dataResponse(response)}';
    log(result);
  }

  String _dataResponse(Response response) {
    if (response.data is Map || response.data is List) {
      return '\n${jsonEncode(response.data ?? {})}';
    } else if (response.data is List) {
      return '\n${jsonEncode(response.data ?? [])}';
    }

    return '';
  }

  @override
  onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) async {
    _debugPrint(err.response, true);
    return super.onError(err, handler);
  }
}