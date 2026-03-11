import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_metric.g.dart';

@JsonSerializable()
@immutable
final class UserMetric extends Equatable implements BaseModel<UserMetric> {
  const UserMetric({
    this.weightDiff,
    this.bmi,
    this.id,
    this.date,
    this.weight,
    this.userMetric,
    this.userId,
    this.height,
    this.createdAt,
    this.synced,
  });

  @override
  factory UserMetric.fromJson(Json json) => _$UserMetricFromJson(json);

  @override
  Json toJson() => _$UserMetricToJson(this);

  UserMetric copyWith({
    int? id,
    int? userId,
    String? date,
    double? weight,
    double? bmi,
    double? weightDiff,
    BodyMetricResult? userMetric,
    int? height,
    String? createdAt,
    int? synced,
  }) {
    return UserMetric(
      weightDiff: weightDiff ?? this.weightDiff,
      bmi: bmi ?? this.bmi,
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      userId: userId ?? this.userId,
      userMetric: userMetric ?? this.userMetric,
      height: height ?? this.height,
      createdAt: createdAt ?? this.createdAt,
      synced: synced ?? this.synced,
    );
  }

  @override
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  final String? date;
  final double? weight;
  final double? bmi;
  @JsonKey(name: 'weight_diff')
  final double? weightDiff;
  @JsonKey(name: 'body_metric')
  final BodyMetricResult? userMetric;
  final int? height;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// 0 = not yet synced to server, 1 = synced. Local-only field.
  final int? synced;

  @override
  List<Object?> get props => [
    id,
    date,
    weight,
    userMetric,
    bmi,
    weightDiff,
    userId,
    height,
    createdAt,
    synced,
  ];
}
