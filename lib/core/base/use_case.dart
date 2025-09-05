import 'package:flutter/material.dart';

@immutable
// ignore: one_member_abstracts
abstract interface class UseCase<OUT, IN> {
  Future<OUT?> executeWithParams({IN? params});
}
