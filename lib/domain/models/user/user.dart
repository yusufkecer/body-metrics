import 'package:bmicalculator/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
final class User extends Equatable implements BaseModel<User>, IdModel {
  @override
  final int? id;
  final String? name;
  final String? surname;
  final String? gender;

  final List<BMI>? bmi;

  const User({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.bmi,
  });

  const User.copyWith({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.bmi,
  });

  @override
  List<Object?> get props => [name, surname, gender];

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
