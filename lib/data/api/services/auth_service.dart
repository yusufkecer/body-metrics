import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService implements AuthServiceBase {
  AuthService(
    this._apiClient,
    this._appCache,
    this._userCache,
    this._userMetricsCache,
    this._secureTokenService,
  );

  final ApiClient _apiClient;
  final AppCache _appCache;
  final UserCache _userCache;
  final UserMetricsCache _userMetricsCache;
  final SecureTokenServiceBase _secureTokenService;

  @override
  Future<bool> hasSession() async {
    final token = await _secureTokenService.getToken();
    final email = await _secureTokenService.getEmail();

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
  Future<void> forgotPassword({required String email}) async {
    try {
      await _apiClient.dio.post<Map<String, dynamic>>(
        '/auth/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    try {
      await _apiClient.dio.post<Map<String, dynamic>>(
        '/auth/reset-password',
        data: {'email': email, 'token': token, 'password': password},
      );
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
      '${AppCacheColumns.page.value} = NULL',
    );

    await _appCache.closeDb();
    await _secureTokenService.clearSession();

    AppUtil.currentUserId = null;
    AppUtil.lastPage = null;
    AppUtil.hasSession = false;
  }

  Future<void> _saveSession({
    required String email,
    required String token,
  }) async {
    await _secureTokenService.saveSession(token: token, email: email);
    AppUtil.hasSession = true;
  }
}
