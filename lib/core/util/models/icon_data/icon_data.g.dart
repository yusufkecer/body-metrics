// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconDataModel _$IconDataModelFromJson(Map<String, dynamic> json) =>
    IconDataModel(
      codePoint: (json['codePoint'] as num).toInt(),
      fontFamily: json['fontFamily'] as String?,
      fontPackage: json['fontPackage'] as String?,
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );

Map<String, dynamic> _$IconDataModelToJson(IconDataModel instance) =>
    <String, dynamic>{
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'fontPackage': instance.fontPackage,
      'matchTextDirection': instance.matchTextDirection,
    };
