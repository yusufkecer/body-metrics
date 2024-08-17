import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_metric.g.dart';

@JsonSerializable()
class UserMetric extends Equatable implements BaseModel<UserMetric> {
  const UserMetric({this.date, this.height, this.weight, this.bodymetricsResult});

  const UserMetric.copyWith({this.date, this.height, this.weight, this.bodymetricsResult});

  final String? date;
  final String? height;
  final String? weight;
  final BMIResult? bodymetricsResult;

  @override
  factory UserMetric.fromJson(Map<String, dynamic> json) => _$UserMetricFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserMetricToJson(this);

  @override
  List<Object?> get props => [date];
}
