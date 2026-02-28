import 'package:flutter/material.dart';

@immutable
abstract interface class SyncDataRepositoryBase {
  Future<void> sync();
  Future<void> restore();
  Future<void> markPending();
  Future<void> restorePendingStatus();
}
