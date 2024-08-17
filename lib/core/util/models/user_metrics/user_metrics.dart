import 'package:bodymetrics/core/index.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_metrics.g.dart';

@immutable
@JsonSerializable()
final class UserMetrics extends Equatable implements BaseModel<UserMetrics> {
  final List<UserMetrics>? bodymetricss;

  const UserMetrics({this.bodymetricss});
  @override
  List<Object?> get props => [bodymetricss];

  factory UserMetrics.fromJson(Map<String, dynamic> json) => _$UserMetricsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserMetricsToJson(this);
}
