import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class UserMetricEntity {
  const UserMetricEntity({
    required this.data,
    this.filters,
  });

  final Json? filters;
  final Json data;
}
