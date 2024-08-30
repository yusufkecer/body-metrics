part of 'create_profile.dart';

mixin UserInfoFormModel on State<UserInfoForm>, DialogUtil {
  final TextEditingController _fullNameController = TextEditingController();
  final DateController _birthOfDateController = DateController();
  final ValueNotifier<_FormControl> _valueNotifier = ValueNotifier<_FormControl>(const _FormControl());

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthOfDateController.dispose();
    _valueNotifier.dispose();
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

  bool get isAnyProgress => _valueNotifier.value._isFormEmpty;

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

    _valueNotifier.value = _valueNotifier.value.copyWith(isFormEmpty: isFormFilled);
  }

  bool _checkFields() {
    return _fullNameController.text.isNotEmpty || _birthOfDateController.text.isNotEmpty;
  }

  Future<void> _didPop({required bool didPop, required bool isFormEmpty}) async {
    if (!isFormEmpty && mounted) {
      await context.maybePop();
      return;
    }

    final result = await confirmDialog(LocaleKeys.dialog_progress_lost.tr());
    if ((result.isNotNull && !result!) || !context.mounted) return;
    _valueNotifier.value = _valueNotifier.value.copyWith(isFormEmpty: false);
    Future.delayed(const ProductDuration.ms100(), () {
      context.maybePop();
    });
  }
}
