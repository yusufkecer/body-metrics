import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_metric.g.dart';

@JsonSerializable()
@immutable
final class UserMetric extends Equatable implements BaseModel<UserMetric> {
  const UserMetric({this.bmi, this.id, this.date, this.height, this.weight, this.userMetric});

  const UserMetric.copyWith({this.bmi, this.id, this.date, this.height, this.weight, this.userMetric});

  @override
  factory UserMetric.fromJson(Map<String, dynamic> json) => _$UserMetricFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserMetricToJson(this);

  @override
  final int? id;
  final String? date;
  final double? height;
  final double? weight;
  final double? bmi;
  final BodyMetricResult? userMetric;

  @override
  List<Object?> get props => [date, height, weight, userMetric];
}
