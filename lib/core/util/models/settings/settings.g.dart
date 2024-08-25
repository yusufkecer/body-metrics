// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      theme: json['theme'] as String?,
      language: json['language'] as String?,
      completedOnboarding: json['completedOnboarding'] as bool?,
      page: $enumDecodeNullable(_$PagesEnumMap, json['page']),
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'theme': instance.theme,
      'language': instance.language,
      'page': _$PagesEnumMap[instance.page],
      'completedOnboarding': instance.completedOnboarding,
    };

const _$PagesEnumMap = {
  Pages.avatarPage: 'avatarPage',
  Pages.createProfilePage: 'createProfilePage',
  Pages.genderPage: 'genderPage',
  Pages.heightPage: 'heightPage',
  Pages.weightPage: 'weightPage',
};
