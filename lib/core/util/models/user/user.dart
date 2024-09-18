import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable implements BaseModel<User> {
  const User({
    this.height,
    this.id,
    this.avatar,
    this.name,
    this.gender,
    this.userMetrics,
    this.birthOfDate,
  });

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  const User.copyWith({
    this.height,
    this.id,
    this.avatar,
    this.name,
    this.gender,
    this.userMetrics,
    this.birthOfDate,
  });

  @override
  List<Object?> get props => [name, gender, userMetrics, id, birthOfDate];

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  final int? id;
  final String? name;
  final String? avatar;
  final GenderValue? gender;
  final double? height;
  @JsonKey(includeToJson: false)
  final UserMetric? userMetrics;
  final String? birthOfDate;
}
