// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      gender: json['gender'] as String?,
      bmi: (json['bmi'] as List<dynamic>?)
          ?.map((e) => BMI.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'bmi': instance.bmi,
    };
