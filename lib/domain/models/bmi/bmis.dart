import 'package:bodymetrics/core/base/base_model.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bmis.g.dart';

@immutable
@JsonSerializable()
final class BMIS extends Equatable implements BaseModel<BMIS> {
  final List<BMI>? bmis;

  const BMIS({this.bmis});
  @override
  List<Object?> get props => [bmis];

  factory BMIS.fromJson(Map<String, dynamic> json) => _$BMISFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BMISToJson(this);
}
