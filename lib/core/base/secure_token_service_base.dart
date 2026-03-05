import 'package:flutter/material.dart';

@immutable
abstract interface class SecureTokenServiceBase {
  Future<void> saveSession({required String token, required String email});
  Future<String?> getToken();
  Future<String?> getEmail();
  Future<void> clearSession();
}
