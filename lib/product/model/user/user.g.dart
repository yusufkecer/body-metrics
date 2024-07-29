// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      date: json['date'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'date': instance.date,
      'height': instance.height,
      'weight': instance.weight,
      'gender': instance.gender,
      'age': instance.age,
    };
