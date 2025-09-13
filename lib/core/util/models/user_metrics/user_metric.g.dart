// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetric _$UserMetricFromJson(Map<String, dynamic> json) => UserMetric(
      statusIcon: json['statusIcon'] == null
          ? null
          : IconDataModel.fromJson(json['statusIcon'] as Map<String, dynamic>),
      weightDiff: (json['weightDiff'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      userMetric:
          $enumDecodeNullable(_$BodyMetricResultEnumMap, json['userMetric']),
      userId: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserMetricToJson(UserMetric instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'weight': instance.weight,
      'bmi': instance.bmi,
      'weightDiff': instance.weightDiff,
      'userMetric': _$BodyMetricResultEnumMap[instance.userMetric],
      'statusIcon': instance.statusIcon,
    };

const _$BodyMetricResultEnumMap = {
  BodyMetricResult.underweight: 'underweight',
  BodyMetricResult.normal: 'normal',
  BodyMetricResult.overweight: 'overweight',
  BodyMetricResult.obese: 'obese',
  BodyMetricResult.morbidlyObese: 'morbidlyObese',
  BodyMetricResult.unknown: 'unknown',
};
