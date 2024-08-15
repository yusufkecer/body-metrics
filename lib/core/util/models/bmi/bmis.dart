import 'package:bodymetrics/core/index.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bmis.g.dart';

@immutable
@JsonSerializable()
final class BMIS extends Equatable implements BaseModel<BMIS> {
  final List<BMI>? bodymetricss;

  const BMIS({this.bodymetricss});
  @override
  List<Object?> get props => [bodymetricss];

  factory BMIS.fromJson(Map<String, dynamic> json) => _$BMISFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BMISToJson(this);
}
