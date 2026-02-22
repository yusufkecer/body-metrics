import 'package:bodymetrics/core/index.dart';
import 'package:dio/dio.dart';

final class LoadingInterceptor extends Interceptor {
  final GlobalLoadingControllerBase _controller =
      GlobalLoadingController.contract;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _controller.show();
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _controller.hide();
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _controller.hide();
    handler.next(err);
  }
}
