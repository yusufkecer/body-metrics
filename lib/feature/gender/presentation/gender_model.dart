part of 'gender.dart';

mixin _GenderModel on State<_GenderView>, SavePageMixin {
  bool? _isMale;
  bool? _isFemale;
  void onChange({bool? value, bool isMale = false, bool isFemale = false}) {
    if (value == null) return;

    if (isMale) {
      _isMale = (_isMale ?? false) ? null : value;
      _isFemale = (_isMale == null) ? null : !value;
    } else if (isFemale) {
      _isFemale = (_isFemale ?? false) ? null : value;
      _isMale = (_isFemale == null) ? null : !value;
    }

    if (_isMale ?? false) {
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.male));
    } else if (_isFemale ?? false) {
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.female));
    } else {
      context.read<GenderCubit>().changeGender(const SelectGender());
    }
  }

  void _pushToHeight() {
    setPage(Pages.heightPage);
    context.router.push(
      HeightView(
        isFemale: _isFemale!,
      ),
    );
  }

  bool isSelected() => _isMale.isNotNull || _isFemale.isNotNull;
}
