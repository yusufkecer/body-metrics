import 'package:bodymetrics/core/enum/pages.dart';
import 'package:flutter/material.dart';

@immutable
final class AppUtil {
  // Application configuration
  static late int? currentUserId;
  static late Pages? lastPage;
  static bool hasSession = false;
  // Application constants
  static const String appName = 'BodyMetrics';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appPackage = 'com.bodymetrics.app';
  // Database constants
  static const int databaseVersion = 1;
  static const String databasePath = 'body_metrics.db';
}
