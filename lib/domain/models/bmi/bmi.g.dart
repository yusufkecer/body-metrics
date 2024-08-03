// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BMI _$BMIFromJson(Map<String, dynamic> json) => BMI(
      date: json['date'] as String?,
      bmiResult: $enumDecodeNullable(_$BMIResultEnumMap, json['bmiResult']),
    );

Map<String, dynamic> _$BMIToJson(BMI instance) => <String, dynamic>{
      'date': instance.date,
      'bmiResult': _$BMIResultEnumMap[instance.bmiResult],
    };

const _$BMIResultEnumMap = {
  BMIResult.underweight: 'underweight',
  BMIResult.normal: 'normal',
  BMIResult.overweight: 'overweight',
  BMIResult.obese: 'obese',
  BMIResult.morbidlyObese: 'morbidlyObese',
};
