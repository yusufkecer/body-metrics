part of '../../create_profile.dart';

class _FormControl extends Equatable {
  final bool _isFormEmpty;

  const _FormControl({
    bool isFormEmpty = false,
  }) : _isFormEmpty = isFormEmpty;

  _FormControl copyWith({
    bool? isFormEmpty,
  }) {
    return _FormControl(
      isFormEmpty: isFormEmpty ?? _isFormEmpty,
    );
  }

  @override
  List<Object?> get props => [_isFormEmpty];
}
