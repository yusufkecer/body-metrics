import 'package:bodymetrics/core/index.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_metrics.g.dart';

@immutable
@JsonSerializable()
final class UserMetrics extends Equatable implements BaseModel<UserMetrics> {
  const UserMetrics({this.userMetrics});

  factory UserMetrics.fromJson(Map<String, dynamic> json) => _$UserMetricsFromJson(json);

  final List<UserMetric>? userMetrics;

  @override
  List<Object?> get props => [userMetrics];

  @override
  Map<String, dynamic> toJson() => _$UserMetricsToJson(this);

  @override
  int? get id => throw UnimplementedError();
}
