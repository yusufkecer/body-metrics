import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class CreateProfileEntity extends Equatable {
  final bool _isFormEmpty;

  const CreateProfileEntity({
    bool isFormEmpty = false,
  }) : _isFormEmpty = isFormEmpty;

  CreateProfileEntity copyWith({
    bool? isFormEmpty,
  }) {
    return CreateProfileEntity(
      isFormEmpty: isFormEmpty ?? _isFormEmpty,
    );
  }

  bool get isFormEmpty => _isFormEmpty;

  @override
  List<Object?> get props => [_isFormEmpty];
}
