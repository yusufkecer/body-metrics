import 'package:bodymetrics/core/type_def.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class UserApiServiceBase {
  Future<Json> createUser(Json data);
  Future<Json?> getUserById(int id);
  Future<List<Json>> getAllUsers();
  Future<Json?> updateUser(int id, Json data);
}
