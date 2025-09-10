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
    String? birthOfDate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name ?? '',
      surname: surname ?? this.surname ?? '',
      avatar: avatar ?? this.avatar ?? '',
      gender: gender ?? this.gender,
      height: height ?? this.height,
      birthOfDate: birthOfDate ?? this.birthOfDate,
    );
  }

  @override
  List<Object?> get props => [name, gender, id, birthOfDate, surname];

  @override
  Json toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(id: $id, name: $name, surname: $surname, avatar: $avatar, gender: $gender, height: $height, birthOfDate: $birthOfDate)';
  }

  @override
  final int? id;
  final String? name;
  final String? surname;
  final String? avatar;
  final GenderValue? gender;
  final int? height;

  final String? birthOfDate;
}
