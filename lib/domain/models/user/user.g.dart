// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: $enumDecodeNullable(_$GenderValuesEnumMap, json['gender']),
      bmis: json['bmis'] == null
          ? null
          : BMIS.fromJson(json['bmis'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'gender': _$GenderValuesEnumMap[instance.gender],
    };

const _$GenderValuesEnumMap = {
  GenderValues.male: 'male',
  GenderValues.female: 'female',
};
