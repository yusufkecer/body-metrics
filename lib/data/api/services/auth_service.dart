import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class AuthService implements AuthServiceBase {
  AuthService(this._apiClient, this._userCache, this._userMetricsCache);

  final ApiClient _apiClient;
  final UserCache _userCache;
  final UserMetricsCache _userMetricsCache;

  @override
  Future<bool> hasSession() async {
    final appCache = Locator.sl<AppCache>();
    final db = await appCache.initializeDatabase();
    final data = await appCache.selectAll(db);

    final token = data[AppCacheColumns.jwtToken.value] as String?;
    final email = data[AppCacheColumns.email.value] as String?;

    return (token?.isNotEmpty ?? false) && (email?.isNotEmpty ?? false);
  }

  @override
  Future<void> restoreSessionFromCache() async {
    await hasSession();
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post<Map<String, dynamic>>(
        '/auth/register',
        data: {'email': email, 'password': password},
      );
      final token = response.data?['token'] as String?;
      if (token == null || token.isEmpty) {
        throw const ApiException(message: 'Token is missing');
      }
      await _saveSession(email: email, token: token);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final response = await _apiClient.dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final token = response.data?['token'] as String?;
      if (token == null || token.isEmpty) {
        throw const ApiException(message: 'Token is missing');
      }
      await _saveSession(email: email, token: token);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> logoutLocal() async {
    final appCache = Locator.sl<AppCache>();
    final db = await appCache.initializeDatabase();
    if (db == null) return;

    await db.delete(_userMetricsCache.table);

    await db.delete(_userCache.table);

    await db.delete(appCache.table);

    await appCache.closeDb();

    AppUtil.currentUserId = null;
    AppUtil.lastPage = null;
  }

  Future<void> _saveSession({
    required String email,
    required String token,
  }) async {
    final appCache = Locator.sl<AppCache>();
    final db = await appCache.initializeDatabase();
    final updated = await appCache.update(db, {
      AppCacheColumns.jwtToken.value: token,
      AppCacheColumns.email.value: email,
    });
    if (updated > 0) return;

    final db2 = await appCache.initializeDatabase();
    await appCache.insert(db2, {
      AppCacheColumns.jwtToken.value: token,
      AppCacheColumns.email.value: email,
    });
  }
}
