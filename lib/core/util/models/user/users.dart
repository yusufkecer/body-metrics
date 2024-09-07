import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';

@JsonSerializable()
@immutable
final class Users extends Equatable implements BaseModel<Users> {
  final List<User>? users;

  const Users({this.users});

  @override
  List<Object?> get props => [users];

  @override
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  @override
  // TODO: implement id
  int? get id => throw UnimplementedError();
}
