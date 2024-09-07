// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetrics _$UserMetricsFromJson(Map<String, dynamic> json) => UserMetrics(
      userMetrics: (json['userMetrics'] as List<dynamic>?)
          ?.map((e) => UserMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserMetricsToJson(UserMetrics instance) =>
    <String, dynamic>{
      'userMetrics': instance.userMetrics,
    };
