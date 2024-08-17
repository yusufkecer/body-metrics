// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetrics _$UserMetricsFromJson(Map<String, dynamic> json) => UserMetrics(
      bodymetricss: (json['bodymetricss'] as List<dynamic>?)
          ?.map((e) => UserMetrics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserMetricsToJson(UserMetrics instance) =>
    <String, dynamic>{
      'bodymetricss': instance.bodymetricss,
    };
