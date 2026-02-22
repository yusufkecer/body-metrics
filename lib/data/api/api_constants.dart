import 'package:bodymetrics/data/api/env/env.dart';
import 'package:flutter/material.dart';

@immutable
abstract final class ApiConstants {
  static const _flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'local',
  );

  static const _localIp = String.fromEnvironment('LOCAL_IP');

  static String get baseUrl => switch (_flavor) {
    'production' =>
      'https://body-metrics-backend-production.up.railway.app/api/v1',
    'local_ios' => 'http://localhost:8080/api/v1',
    'local' when _localIp.isNotEmpty => 'http://$_localIp:8080/api/v1',
    _ => 'http://10.0.2.2:8080/api/v1',
  };

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static String get apiKey => Env.apiKey;
}
