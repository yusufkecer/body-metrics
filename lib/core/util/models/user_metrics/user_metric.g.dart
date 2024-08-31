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
          $enumDecodeNullable(_$BmiResultEnumMap, json['bodymetricsResult']),
    );

Map<String, dynamic> _$UserMetricToJson(UserMetric instance) =>
    <String, dynamic>{
      'date': instance.date,
      'height': instance.height,
      'weight': instance.weight,
      'bodymetricsResult': _$BmiResultEnumMap[instance.bodymetricsResult],
    };

const _$BmiResultEnumMap = {
  BmiResult.underweight: 'underweight',
  BmiResult.normal: 'normal',
  BmiResult.overweight: 'overweight',
  BmiResult.obese: 'obese',
  BmiResult.morbidlyObese: 'morbidlyObese',
  BmiResult.unknown: 'unknown',
};
