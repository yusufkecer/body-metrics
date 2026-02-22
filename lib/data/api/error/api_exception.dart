import 'package:dio/dio.dart';

final class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    String message;
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      message = data['error'] as String;
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          message = 'Connection timeout';
        case DioExceptionType.connectionError:
          message = 'No internet connection';
        case DioExceptionType.badResponse:
          message = 'Server error ($statusCode)';
        case DioExceptionType.cancel:
          message = 'No active session';
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          message = 'Unexpected error';
      }
    }

    return ApiException(message: message, statusCode: statusCode);
  }

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
