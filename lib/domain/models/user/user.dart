import 'package:bmicalculator/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
final class User extends Equatable implements BaseModel<User> {
  final String? name;
  final String? surname;
  final String? date;
  final String? gender;
  final String? height;
  final String? weight;
  final List<BMI>? bmi;

  const User({
    this.name,
    this.surname,
    this.date,
    this.gender,
    this.height,
    this.weight,
    this.bmi,
  });

  const User.copyWith({
    this.name,
    this.surname,
    this.date,
    this.gender,
    this.height,
    this.weight,
    this.bmi,
  });

  @override
  List<Object?> get props => [name, surname, date, gender, height, weight];

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
