import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/api/api_client.dart';
import 'package:bodymetrics/data/api/error/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class UserApiService implements UserApiServiceBase {
  const UserApiService(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Json> createUser(Json data) async {
    try {
      final response = await _apiClient.dio.post<Json>('/users', data: data);
      return response.data ?? {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<Json?> getUserById(int id) async {
    try {
      final response = await _apiClient.dio.get<Json>('/users/$id');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<Json>> getAllUsers() async {
    try {
      final response = await _apiClient.dio.get<List<dynamic>>('/users');
      return (response.data ?? []).cast<Json>();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<Json?> updateUser(int id, Json data) async {
    try {
      final response = await _apiClient.dio.patch<Json>(
        '/users/$id',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
