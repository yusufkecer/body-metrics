import 'dart:convert';

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
    this._userApiService,
  );

  final ApiClient _apiClient;
  final AppCache _appCache;
  final UserCache _userCache;
  final UserMetricsCache _userMetricsCache;
  final UserApiServiceBase _userApiService;

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
    if (updated <= 0) {
      final db2 = await _appCache.initializeDatabase();
      await _appCache.insert(db2, {
        AppCacheColumns.jwtToken.value: token,
        AppCacheColumns.email.value: email,
      });
    }

    final accountId = _extractAccountId(token);
    if (accountId == null) {
      return;
    }

    try {
      final userJson = await _userApiService.getUserById(accountId);
      if (userJson == null) {
        return;
      }

      final userDb = await _userCache.initializeDatabase();
      final existing = await _userCache.select(
        userDb,
        {UserCacheColumns.id.value: accountId},
      );

      int localUserId;
      if (existing?.users?.isNotEmpty ?? false) {
        localUserId = existing!.users!.first.id!;
      } else {
        final insertDb = await _userCache.initializeDatabase();
        final payload = _buildUserCachePayload(userJson);
        final insertedId = await _userCache.insert(insertDb, payload);
        if (insertedId <= 0) {
          return;
        }
        localUserId = insertedId;
      }

      AppUtil.currentUserId = localUserId;

      final appDb = await _appCache.initializeDatabase();
      await _appCache.update(appDb, {
        AppCacheColumns.activeUser.value: localUserId,
      });
    } catch (e) {
      
    }
  }

  int? _extractAccountId(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final normalized = base64Url.normalize(parts[1]);
      final payloadBytes = base64Url.decode(normalized);
      final payloadJson = utf8.decode(payloadBytes);
      final payload = json.decode(payloadJson) as Map<String, dynamic>;

      return (payload['account_id'] as num?)?.toInt();
    } catch (e) {
      return null;
    }
  }

  Json _buildUserCachePayload(Json serverUser) => {
    if (serverUser['name'] != null)
      UserCacheColumns.name.value: serverUser['name'],
    if (serverUser['surname'] != null)
      UserCacheColumns.surname.value: serverUser['surname'],
    if (serverUser['gender'] != null)
      UserCacheColumns.gender.value: serverUser['gender'],
    if (serverUser['avatar'] != null)
      UserCacheColumns.avatar.value: serverUser['avatar'],
    if (serverUser['height'] != null)
      UserCacheColumns.height.value: serverUser['height'],
    if (serverUser['birthOfDate'] != null)
      UserCacheColumns.birthOfDate.value: serverUser['birthOfDate'],
  };
}
