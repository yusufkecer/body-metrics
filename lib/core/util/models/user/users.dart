import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';

@JsonSerializable()
@immutable
final class Users extends Equatable implements BaseModel<Users> {
  const Users({this.users});

  @override
  factory Users.fromJson(Json json) => _$UsersFromJson(json);

  final List<User>? users;

  @override
  List<Object?> get props => [users];

  @override
  Json toJson() => _$UsersToJson(this);

  @override
  int? get id => throw UnimplementedError();
}
