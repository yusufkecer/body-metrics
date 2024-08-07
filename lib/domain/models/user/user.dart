import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/domain/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
@immutable
final class User extends Equatable implements BaseModel<User>, IdModel {
  @override
  final int? id;
  final String? name;
  final String? surname;
  final GenderValues? gender;
  @JsonKey(includeToJson: false)
  final BMIS? bmis;

  const User({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.bmis,
  });

  const User.copyWith({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.bmis,
  });

  @override
  List<Object?> get props => [name, surname, gender];

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
