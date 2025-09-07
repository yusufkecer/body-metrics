import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@immutable
class User extends Equatable implements BaseModel<User> {
  const User({
    this.height,
    this.id,
    this.avatar,
    this.name,
    this.surname,
    this.gender,
    this.userMetrics,
    this.birthOfDate,
  });

  @override
  factory User.fromJson(Json json) => _$UserFromJson(json);

  User copyWith({
    String? name,
    String? surname,
    String? avatar,
    int? id,
    GenderValue? gender,
    int? height,
    UserMetric? userMetrics,
    String? birthOfDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name ?? '',
      surname: surname ?? this.surname ?? '',
      avatar: avatar ?? this.avatar ?? '',
      gender: gender ?? this.gender,
      height: height ?? this.height,
      userMetrics: userMetrics ?? this.userMetrics,
      birthOfDate: birthOfDate ?? this.birthOfDate,
    );
  }

  @override
  List<Object?> get props => [name, gender, userMetrics, id, birthOfDate, surname];

  @override
  Json toJson() => _$UserToJson(this);

  @override
  final int? id;
  final String? name;
  final String? surname;
  final String? avatar;
  final GenderValue? gender;
  final int? height;
  @JsonKey(includeToJson: false)
  final UserMetric? userMetrics;
  final String? birthOfDate;
}
