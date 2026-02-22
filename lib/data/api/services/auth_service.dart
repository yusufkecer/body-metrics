import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class AuthService implements AuthServiceBase {
  AuthService(
    this._apiClient,
    this._appCache,
    this._userCache,
    this._userMetricsCache,
  );

  final ApiClient _apiClient;
  final AppCache _appCache;
  final UserCache _userCache;
  final UserMetricsCache _userMetricsCache;

  @override
  Future<bool> hasSession() async {
    final db = await _appCache.initializeDatabase();
    final data = await _appCache.selectAll(db);

    final token = data[AppCacheColumns.jwtToken.value] as String?;
    final email = data[AppCacheColumns.email.value] as String?;

    final result = (token?.isNotEmpty ?? false) && (email?.isNotEmpty ?? false);
    AppUtil.hasSession = result;
    return result;
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
    final db = await _appCache.initializeDatabase();
    if (db == null) return;
    await db.delete(_userMetricsCache.table);
    await db.delete(_userCache.table);

    await db.rawUpdate(
      'UPDATE ${_appCache.table} '
      'SET ${AppCacheColumns.activeUser.value} = NULL, '
      '${AppCacheColumns.page.value} = NULL, '
      '${AppCacheColumns.jwtToken.value} = NULL, '
      '${AppCacheColumns.email.value} = NULL',
    );

    await _appCache.closeDb();

    AppUtil.currentUserId = null;
    AppUtil.lastPage = null;
    AppUtil.hasSession = false;
  }

  Future<void> _saveSession({
    required String email,
    required String token,
  }) async {
    final db = await _appCache.initializeDatabase();
    final updated = await _appCache.update(db, {
      AppCacheColumns.jwtToken.value: token,
      AppCacheColumns.email.value: email,
    });
    AppUtil.hasSession = true;
    if (updated > 0) return;

    final db2 = await _appCache.initializeDatabase();
    await _appCache.insert(db2, {
      AppCacheColumns.jwtToken.value: token,
      AppCacheColumns.email.value: email,
    });
  }
}
