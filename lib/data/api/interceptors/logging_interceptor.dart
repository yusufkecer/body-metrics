import 'package:bodymetrics/core/index.dart';
import 'package:dio/dio.dart';

final class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    '→ ${options.method} ${options.path}'.log();
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    '← ${response.statusCode} ${response.requestOptions.path}'.log();
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.cancel) {
      handler.next(err);
      return;
    }
    '✗ ${err.response?.statusCode} ${err.requestOptions.path}: ${err.message}'.e();
    handler.next(err);
  }
}
