part of 'user_general_info.dart';

mixin _UserGeneralInfoModel on State<_UserInfoFormBody>, DialogUtil<_UserInfoFormBody>, SaveAppMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final DateController _birthOfDateController = DateController();
  late final UserInfoFormCubit _cubit = context.read<UserInfoFormCubit>();
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _birthOfDateController.dispose();

    super.dispose();
  }

  Future<void> _onPressed() async {
    if ((_nameController.text.isEmpty || _birthOfDateController.text.isEmpty || _surnameController.text.isEmpty) &&
        mounted) {
      showLottieError(LocaleKeys.register_information_is_empty);
      return;
    }
    await createProfile();
    final state = _cubit.state;
    if (state is UserInfoFormCubitError) {
      showLottieError(state.error ?? LocaleKeys.dialog_general_error);
      return;
    } else if (state is UserInfoFormCubitSuccess) {
      final pageResult = await saveApp(Pages.genderPage);
      if (pageResult != true) {   
        showLottieError(LocaleKeys.dialog_page_not_saved);
        return;
      }
      await pushToGender();
    } else {
      showLottieError(LocaleKeys.dialog_general_error);
    }
  }

  Future<void> pushToGender() async {
    await context.pushRoute(const GenderView());
  }

  Future<void> createProfile() async {
    final birthDay = _birthOfDateController.text.toYMD;
    final user = User(
      name: _nameController.text,
      surname: _surnameController.text,
      birthOfDate: birthDay,
    );

    await _cubit.createProfile(user);
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
    return _nameController.text.isEmpty && _birthOfDateController.text.isEmpty && _surnameController.text.isEmpty;
  }

  Future<void> _didPop({required bool isFormEmpty}) async {
    if (isFormEmpty) {
      await context.maybePop();
      return;
    }

    final result = await confirmDialog(LocaleKeys.dialog_progress_lost.tr());

    if (!mounted || (result.isNotNull && !result!)) return;

    context.read<UserInfoFormCubit>().setFormEmpty(param: true);

    await Future<void>.delayed(Duration.zero);
    if (mounted) await context.maybePop();
  }
}
