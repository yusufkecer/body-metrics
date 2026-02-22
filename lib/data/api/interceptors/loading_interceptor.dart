import 'package:bodymetrics/core/index.dart';
import 'package:dio/dio.dart';

final class LoadingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    GlobalLoadingController.show();
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    GlobalLoadingController.hide();
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    GlobalLoadingController.hide();
    handler.next(err);
  }
}
