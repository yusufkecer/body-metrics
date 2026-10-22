// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppModel _$AppModelFromJson(Map<String, dynamic> json) => AppModel(
  isCompleteOnboard: AppModel._boolFromDb(json['is_completed_onboard']),
  activeUser: (json['active_user'] as num?)?.toInt(),
);

Map<String, dynamic> _$AppModelToJson(AppModel instance) => <String, dynamic>{
  'is_completed_onboard': AppModel._boolToDb(instance.isCompleteOnboard),
  'active_user': instance.activeUser,
};
