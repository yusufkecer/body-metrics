import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:dio/dio.dart';

final class AuthInterceptor extends Interceptor {
  static const _authPrefix = '/auth/';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.startsWith(_authPrefix)) {
      return handler.next(options);
    }

    final tokenService = Locator.sl<SecureTokenServiceBase>();
    final token = await tokenService.getToken();

    if (token == null || token.isEmpty) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No active session — request blocked',
          type: DioExceptionType.cancel,
        ),
      );
    }

    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _clearSession();
    }
    handler.next(err);
  }

  Future<void> _clearSession() async {
    final tokenService = Locator.sl<SecureTokenServiceBase>();
    await tokenService.clearSession();
  }
}
