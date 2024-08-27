import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable implements BaseModel<User>, IdModel {
  @override
  final int? id;
  final String? name;
  final String? avatar;
  final GenderValue? gender;
  @JsonKey(includeToJson: false)
  final UserMetric? userMetrics;
  final String? birthOfDay;

  const User({
    this.id,
    this.avatar,
    this.name,
    this.gender,
    this.userMetrics,
    this.birthOfDay,
  });

  const User.copyWith({
    this.id,
    this.avatar,
    this.name,
    this.gender,
    this.userMetrics,
    this.birthOfDay,
  });

  @override
  List<Object?> get props => [name, gender, userMetrics, id, birthOfDay];

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
