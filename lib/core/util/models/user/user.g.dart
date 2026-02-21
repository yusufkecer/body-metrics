// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  height: (json['height'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  avatar: json['avatar'] as String?,
  name: json['name'] as String?,
  surname: json['surname'] as String?,
  gender: $enumDecodeNullable(_$GenderValueEnumMap, json['gender']),
  birthOfDate: json['birthOfDate'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'surname': instance.surname,
  'avatar': instance.avatar,
  'gender': _$GenderValueEnumMap[instance.gender],
  'height': instance.height,
  'birthOfDate': instance.birthOfDate,
};

const _$GenderValueEnumMap = {
  GenderValue.male: 'male',
  GenderValue.female: 'female',
};
