// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppModel _$AppModelFromJson(Map<String, dynamic> json) => AppModel(
  isCompleteOnboard: json['is_complete_onboard'] as bool?,
  page: $enumDecodeNullable(_$PagesEnumMap, json['page']),
  activeUser: (json['active_user'] as num?)?.toInt(),
);

Map<String, dynamic> _$AppModelToJson(AppModel instance) => <String, dynamic>{
  'page': _$PagesEnumMap[instance.page],
  'is_complete_onboard': instance.isCompleteOnboard,
  'active_user': instance.activeUser,
};

const _$PagesEnumMap = {
  Pages.avatarPage: 'avatarPage',
  Pages.userGeneralInfo: 'userGeneralInfo',
  Pages.genderPage: 'genderPage',
  Pages.heightPage: 'heightPage',
  Pages.weightPage: 'weightPage',
  Pages.homePage: 'homePage',
  Pages.onboardPage: 'onboardPage',
};
