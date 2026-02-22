import 'package:flutter/material.dart';

@immutable
abstract interface class AuthServiceBase {
  Future<bool> hasSession();
  Future<void> restoreSessionFromCache();
  Future<void> register({required String email, required String password});
  Future<void> login({required String email, required String password});
  Future<void> logoutLocal();
}
