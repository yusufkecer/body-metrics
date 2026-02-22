import 'package:bodymetrics/data/api/api_constants.dart';
import 'package:bodymetrics/data/api/interceptors/auth_interceptor.dart';
import 'package:bodymetrics/data/api/interceptors/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class ApiClient {
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          if (ApiConstants.apiKey.isNotEmpty)
            'X-API-Key': ApiConstants.apiKey,
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
    ]);
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
