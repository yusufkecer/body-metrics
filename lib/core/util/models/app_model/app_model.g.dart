// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppModel _$AppModelFromJson(Map<String, dynamic> json) => AppModel(
      theme: json['theme'] as String?,
      language: json['language'] as String?,
      isCompleteOnboard: json['isCompleteOnboard'] as bool?,
      page: $enumDecodeNullable(_$PagesEnumMap, json['page']),
      activeUser: (json['activeUser'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppModelToJson(AppModel instance) => <String, dynamic>{
      'theme': instance.theme,
      'language': instance.language,
      'page': _$PagesEnumMap[instance.page],
      'isCompleteOnboard': instance.isCompleteOnboard,
      'activeUser': instance.activeUser,
    };

const _$PagesEnumMap = {
  Pages.avatarPage: 'avatarPage',
  Pages.userGeneralInfo: 'userGeneralInfo',
  Pages.genderPage: 'genderPage',
  Pages.heightPage: 'heightPage',
  Pages.weightPage: 'weightPage',
};
