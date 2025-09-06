import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_model.g.dart';

@immutable
@JsonSerializable()
final class AppModel extends Equatable implements BaseModel<AppModel> {
  const AppModel({
    this.isCompleteOnboard,
    this.page,
    this.activeUser,
  });
  @override
  factory AppModel.fromJson(Json json) => _$AppModelFromJson(json);

  AppModel copyWith({
    String? theme,
    String? language,
    bool? isCompleteOnboard,
    Pages? page,
    int? activeUser,
  }) =>
      AppModel(
        isCompleteOnboard: isCompleteOnboard ?? this.isCompleteOnboard,
        page: page ?? this.page,
        activeUser: activeUser ?? this.activeUser,
      );
  final Pages? page;
  @JsonKey(name: 'is_complete_onboard')
  final bool? isCompleteOnboard;
  @JsonKey(name: 'active_user')
  final int? activeUser;

  @override
  List<Object?> get props => [isCompleteOnboard, page, activeUser];
  @override
  Json toJson() => _$AppModelToJson(this);

  @override
  int? get id => throw UnimplementedError();
}
