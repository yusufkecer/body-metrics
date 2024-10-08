// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      height: (json['height'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderValueEnumMap, json['gender']),
      userMetrics: json['userMetrics'] == null
          ? null
          : UserMetric.fromJson(json['userMetrics'] as Map<String, dynamic>),
      birthOfDate: json['birthOfDate'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'gender': _$GenderValueEnumMap[instance.gender],
      'height': instance.height,
      'birthOfDate': instance.birthOfDate,
    };

const _$GenderValueEnumMap = {
  GenderValue.male: 'male',
  GenderValue.female: 'female',
};
