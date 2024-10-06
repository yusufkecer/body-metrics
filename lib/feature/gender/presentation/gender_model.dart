part of 'gender.dart';

mixin _GenderModel on State<_GenderView>, SaveAppMixin {
  bool? _isMale;
  bool? _isFemale;
  GenderValue? selectedGender;
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
      selectedGender = GenderValue.male;
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.male));
    } else if (_isFemale ?? false) {
      selectedGender = GenderValue.male;
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.female));
    } else {
      context.read<GenderCubit>().changeGender(const SelectGender());
    }
  }

  Future<void> _pushToHeight() async {
    await _saveGender();
    await saveApp(Pages.heightPage);

    if (!mounted) return;

    await context.router.push(
      HeightView(
        gender: selectedGender!,
      ),
    );
  }

  Future<bool> _saveGender() async {
    final model = context.read<GenderCubit>();
    return await model.saveGender() ?? false;
  }

  bool isSelected() => _isMale.isNotNull || _isFemale.isNotNull;
}
