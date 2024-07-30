import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    this.date,
    this.height,
    this.weight,
    this.gender,
    this.age,
  });

  const User.copyWith({
    this.date,
    this.height,
    this.weight,
    this.gender,
    this.age,
  });

  final String? date;
  final String? height;
  final String? weight;
  final String? gender;
  final int? age;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [date, height, weight, gender, age];
}
