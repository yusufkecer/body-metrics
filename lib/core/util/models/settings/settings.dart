import 'package:bodymetrics/core/base/index.dart';
import 'package:bodymetrics/core/util/constants/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'settings.g.dart';

@immutable
@JsonSerializable()
final class Settings extends Equatable implements BaseModel<Settings> {
  final String? theme;
  final String? language;
  final Pages? page;
  final bool? completedOnboarding;

  const Settings({
    this.theme,
    this.language,
    this.completedOnboarding,
    this.page,
  });

  @override
  List<Object?> get props => [theme, language, completedOnboarding, page];

  @override
  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
