part of 'create_profile.dart';

mixin UserInfoFormModel on State<_UserInfoFormBody>, DialogUtil {
  final TextEditingController _fullNameController = TextEditingController();
  final DateController _birthOfDateController = DateController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthOfDateController.dispose();

    super.dispose();
  }

  Future<void> _onPressed() async {
    if ((_fullNameController.text.isEmpty || _birthOfDateController.text.isEmpty) && mounted) {
      showLottieError(LocaleKeys.register_information_is_empty.tr());
      return;
    }
    final result = await createProfile();
    if (result.isNotNull && result! && mounted) {
      'Success: $result'.log;
      await context.pushRoute(const GenderView());
    } else {
      'Error: $result'.e;
      showLottieError(
        LocaleKeys.dialog_general_error.tr(),
      );
    }
  }

  Future<bool?> createProfile() async {
    final saveUseCase = Locator.sl<CreateProfileUseCase>(param1: CreateProfileRepository());
    final ymd = _birthOfDateController.text.toYMD;
    final user = User(
      name: _fullNameController.text,
      birthOfDay: ymd,
    );

    final result = await saveUseCase.executeWithParams(user);
    return result;
  }

  bool get isAnyProgress => context.read<UserInfoFormCubit>().state.isFormEmpty ?? false;

  void _openDatePicker() {
    showDatePicker(
      barrierColor: ProductColor().seedFourTenths,
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
    return _fullNameController.text.isNotEmpty || _birthOfDateController.text.isNotEmpty;
  }

  Future<void> _didPop({required bool didPop, required bool isFormEmpty}) async {
    print("did ${isFormEmpty}");
    if (!isFormEmpty && mounted) {
      await context.maybePop();
      return;
    }
    print("did2 ${isFormEmpty}");
    final result = await confirmDialog(LocaleKeys.dialog_progress_lost.tr());
    print("did3 ${isFormEmpty}");
    if (!mounted || (result.isNotNull && !result!)) return;
    context.read<UserInfoFormCubit>().setFormEmpty(param: false);

    Future.delayed(const ProductDuration.ms100(), () {
      context.maybePop();
    });
  }
}
