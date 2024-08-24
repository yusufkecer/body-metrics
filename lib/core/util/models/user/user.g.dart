// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderValueEnumMap, json['gender']),
      userMetrics: json['userMetrics'] == null
          ? null
          : UserMetric.fromJson(json['userMetrics'] as Map<String, dynamic>),
      birthOfDay: json['birthOfDay'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'gender': _$GenderValueEnumMap[instance.gender],
      'birthOfDay': instance.birthOfDay,
    };

const _$GenderValueEnumMap = {
  GenderValue.male: 'male',
  GenderValue.female: 'female',
};
