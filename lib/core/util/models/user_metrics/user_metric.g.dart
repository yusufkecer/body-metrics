// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetric _$UserMetricFromJson(Map<String, dynamic> json) => UserMetric(
      date: json['date'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      bodymetricsResult:
          $enumDecodeNullable(_$BMIResultEnumMap, json['bodymetricsResult']),
    );

Map<String, dynamic> _$UserMetricToJson(UserMetric instance) =>
    <String, dynamic>{
      'date': instance.date,
      'height': instance.height,
      'weight': instance.weight,
      'bodymetricsResult': _$BMIResultEnumMap[instance.bodymetricsResult],
    };

const _$BMIResultEnumMap = {
  BMIResult.underweight: 'underweight',
  BMIResult.normal: 'normal',
  BMIResult.overweight: 'overweight',
  BMIResult.obese: 'obese',
  BMIResult.morbidlyObese: 'morbidlyObese',
  BMIResult.unknown: 'unknown',
};
