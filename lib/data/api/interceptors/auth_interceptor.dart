import 'package:bodymetrics/data/index.dart';
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

    final appCache = Locator.sl<AppCache>();
    final db = await appCache.initializeDatabase();
    final data = await appCache.selectAll(db);

    final token = data[AppCacheColumns.jwtToken.value] as String?;

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
    final appCache = Locator.sl<AppCache>();
    final db = await appCache.initializeDatabase();
    if (db == null) return;
    await db.rawUpdate(
      'UPDATE ${appCache.table} '
      'SET ${AppCacheColumns.jwtToken.value} = NULL, '
      '${AppCacheColumns.email.value} = NULL',
    );
    await appCache.closeDb();
  }
}
