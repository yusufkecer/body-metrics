import 'package:bmicalculator/domain/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bmis.g.dart';

@immutable
@JsonSerializable()
final class BMIS extends Equatable {
  final List<BMI>? bmis;

  const BMIS({this.bmis});
  @override
  List<Object?> get props => [bmis];

  factory BMIS.fromJson(Map<String, dynamic> json) => _$BMISFromJson(json);
}
