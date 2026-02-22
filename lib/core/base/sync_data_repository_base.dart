import 'package:flutter/material.dart';

@immutable
// ignore: one_member_abstracts
abstract interface class SyncDataRepositoryBase {
  Future<void> sync();
}
