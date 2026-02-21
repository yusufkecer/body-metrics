// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetric _$UserMetricFromJson(Map<String, dynamic> json) => UserMetric(
      weightDiff: (json['weight_diff'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      userMetric:
          $enumDecodeNullable(_$BodyMetricResultEnumMap, json['body_metric']),
      userId: (json['user_id'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$UserMetricToJson(UserMetric instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'weight': instance.weight,
      'bmi': instance.bmi,
      'weight_diff': instance.weightDiff,
      'body_metric': _$BodyMetricResultEnumMap[instance.userMetric],
      'height': instance.height,
      'created_at': instance.createdAt,
    };

const _$BodyMetricResultEnumMap = {
  BodyMetricResult.underweight: 'underweight',
  BodyMetricResult.normal: 'normal',
  BodyMetricResult.overweight: 'overweight',
  BodyMetricResult.obese: 'obese',
  BodyMetricResult.morbidlyObese: 'morbidlyObese',
  BodyMetricResult.unknown: 'unknown',
};
