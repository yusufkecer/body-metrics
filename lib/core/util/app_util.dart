import 'package:bodymetrics/core/util/constants/pages.dart';
import 'package:flutter/material.dart';

@immutable
final class AppUtil {
  static late int? currentUserId;
  static late Pages? lastPage;

  static const String appName = 'BodyMetrics';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appPackage = 'com.bodymetrics.app';
}
