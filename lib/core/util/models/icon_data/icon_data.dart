import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'icon_data.g.dart';

@JsonSerializable()
class IconDataModel extends Equatable {
  const IconDataModel({
    required this.codePoint,
    this.fontFamily,
    this.fontPackage,
    this.matchTextDirection = false,
  });

  factory IconDataModel.fromJson(Json json) => _$IconDataModelFromJson(json);
  Json toIcon() => _$IconDataModelToJson(this);

  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;
  final bool matchTextDirection;

  @override
  List<Object?> get props => [codePoint, fontFamily, fontPackage, matchTextDirection];
}
