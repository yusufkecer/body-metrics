import 'package:flutter/material.dart';

@immutable
abstract interface class BaseRepository<OUT, IN> {
  Future<OUT?> executeWithParams({IN params});
}
