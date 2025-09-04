part of 'gender.dart';

mixin _GenderModel on State<_GenderView>, SaveAppMixin, DialogUtil<_GenderView> {
  GenderValue? selectedGender;

  void onChange(GenderValue gender) {
    if (selectedGender == gender) {
      selectedGender = null;
      context.read<GenderCubit>().selectGender(gender);
    } else {
      selectedGender = gender;
      context.read<GenderCubit>().selectGender(gender);
    }
  }

  Future<void> _pushToHeight() async {
    if (selectedGender.isNull) return;
    final genderCubit = context.read<GenderCubit>();

    final result = await _saveGender(genderCubit);

    if (genderCubit.state is GenderError) {
      showLottieError((genderCubit.state as GenderError).error);
      return;
    }

    if (result == false) {
      showLottieError(LocaleKeys.dialog_general_error);
      return;
    }

    await saveApp(Pages.heightPage);

    if (!mounted) return;

    goToHeight();
  }

  void goToHeight() {
    context.router.push(
      HeightView(
        gender: selectedGender!,
      ),
    );
  }

  Future<bool> _saveGender(GenderCubit cubit) async {
    return cubit.saveGender();
  }
}
