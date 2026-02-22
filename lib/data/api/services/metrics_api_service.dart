import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/api/api_client.dart';
import 'package:bodymetrics/data/api/error/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MetricsApiServiceBase)
final class MetricsApiService implements MetricsApiServiceBase {
  const MetricsApiService(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Json> createMetric(int userId, Json data) async {
    try {
      final response = await _apiClient.dio.post<Json>(
        '/users/$userId/metrics',
        data: data,
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<Json>> getMetricsByUserId(int userId) async {
    try {
      final response = await _apiClient.dio.get<List<dynamic>>(
        '/users/$userId/metrics',
      );
      return (response.data ?? []).cast<Json>();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
