import 'package:bodymetrics/core/base/index.dart';
import 'package:bodymetrics/core/util/constants/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_model.g.dart';

@immutable
@JsonSerializable()
final class AppModel extends Equatable implements BaseModel<AppModel> {
  final String? theme;
  final String? language;
  final Pages? page;
  final bool? isCompleteOnboard;
  final int? activeUser;

  const AppModel({
    this.theme,
    this.language,
    this.isCompleteOnboard,
    this.page,
    this.activeUser,
  });

  @override
  List<Object?> get props => [theme, language, isCompleteOnboard, page, activeUser];

  @override
  factory AppModel.fromJson(Map<String, dynamic> json) => _$AppModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AppModelToJson(this);
}
