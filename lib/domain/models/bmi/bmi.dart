import 'package:bmicalculator/core/index.dart';
import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'bmi.g.dart';

@JsonSerializable()
class BMI extends Equatable implements BaseModel<BMI> {
  const BMI({this.date, this.bmiResult});

  const BMI.copyWith({this.date, this.bmiResult});

  final String? date;
  final BMIResult? bmiResult;

  @override
  factory BMI.fromJson(Map<String, dynamic> json) => _$BMIFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BMIToJson(this);

  @override
  List<Object?> get props => [date];
}
