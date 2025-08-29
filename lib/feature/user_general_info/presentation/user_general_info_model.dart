part of 'user_general_info.dart';

mixin UserGeneralInfoModel
    on State<_UserInfoFormBody>, DialogUtil, SaveAppMixin {
  final TextEditingController _fullNameController = TextEditingController();
  final DateController _birthOfDateController = DateController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthOfDateController.dispose();

    super.dispose();
  }

  Future<void> _onPressed() async {
    if ((_fullNameController.text.isEmpty ||
            _birthOfDateController.text.isEmpty) &&
        mounted) {
      showLottieError(LocaleKeys.register_information_is_empty);
      return;
    }
    final result = await createProfile();
    if ((result.isNotNull && result!) && mounted) {
      await context.pushRoute(const GenderView());
    } else {
      showLottieError(
        LocaleKeys.dialog_general_error,
      );
    }
  }

  Future<bool?> createProfile() async {
    final saveUseCase = Locator.sl<CreateProfileUseCase>();
    final birthDay = _birthOfDateController.text.toYMD;
    final user = User(
      name: _fullNameController.text,
      birthOfDate: birthDay,
    );
    final pageResult = await saveApp(Pages.genderPage);
    if (pageResult != true) {
      showLottieError(LocaleKeys.dialog_page_not_saved);
    }
    final result = await saveUseCase.executeWithParams(user);
    return result;
  }

  void _openDatePicker() {
    showDatePicker(
      barrierColor: ProductColor.instance.seedFourTenths,
      context: context,
      initialDate: ProductDateTime.birthInitialDate(),
      firstDate: ProductDateTime.birthLastDate(),
      lastDate: ProductDateTime.now(),
    ).then((value) {
      if (value == null) return;
      _birthOfDateController.setDate(value);
    });
  }

  void _formListener() {
    final isFormFilled = _checkFields();
    context.read<UserInfoFormCubit>().setFormEmpty(param: isFormFilled);
  }

  bool _checkFields() {
    return _fullNameController.text.isEmpty &&
        _birthOfDateController.text.isEmpty;
  }

  Future<void> _didPop({required bool isFormEmpty}) async {
    if (isFormEmpty) {
      await context.maybePop();
      return;
    }

    final result = await confirmDialog(LocaleKeys.dialog_progress_lost.tr());

    if (!mounted || (result.isNotNull && !result!)) {
      return;
    }

    context.read<UserInfoFormCubit>().setFormEmpty(param: true);

    await Future<void>.delayed(Duration.zero);
    if (mounted) await context.maybePop();
  }
}
