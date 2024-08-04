// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BMIS _$BMISFromJson(Map<String, dynamic> json) => BMIS(
      bmis: (json['bmis'] as List<dynamic>?)
          ?.map((e) => BMI.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BMISToJson(BMIS instance) => <String, dynamic>{
      'bmis': instance.bmis,
    };
