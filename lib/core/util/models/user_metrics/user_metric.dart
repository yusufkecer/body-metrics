import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_metric.g.dart';

@JsonSerializable()
@immutable
final class UserMetric extends Equatable implements BaseModel<UserMetric> {
  const UserMetric({this.statusIcon, this.weightDiff, this.bmi, this.id, this.date, this.weight, this.userMetric});

  @override
  factory UserMetric.fromJson(Map<String, dynamic> json) => _$UserMetricFromJson(json);

  UserMetric.copyWith(UserMetric userMetric)
      : this(
          weightDiff: userMetric.weightDiff,
          bmi: userMetric.bmi,
          id: userMetric.id,
          date: userMetric.date,
          weight: userMetric.weight,
          userMetric: userMetric.userMetric,
        );

  UserMetric copyWith({
    int? id,
    String? date,
    double? weight,
    double? bmi,
    double? weightDiff,
    BodyMetricResult? userMetric,
  }) {
    return UserMetric(
      weightDiff: weightDiff ?? this.weightDiff,
      bmi: bmi ?? this.bmi,
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      userMetric: userMetric ?? this.userMetric,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$UserMetricToJson(this);

  @override
  final int? id;
  final String? date;
  final double? weight;
  final double? bmi;
  final double? weightDiff;
  final BodyMetricResult? userMetric;
  final IconData? statusIcon;

  @override
  List<Object?> get props => [id, date, weight, userMetric, bmi, weightDiff];
}
