import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class OnboardEntity extends Equatable implements BaseModel<OnboardEntity> {
  const OnboardEntity({this.isCompleted = 0});

  final int isCompleted;

  @override
  List<Object?> get props => [isCompleted];

  @override
  Map<String, dynamic> toJson() {
    return {
      'isCompleted': isCompleted,
    };
  }
}
