part of 'create_profile.dart';

mixin UserInfoFormModel on State<UserInfoForm>, DialogUtil {
  final TextEditingController _fullNameController = TextEditingController();
  final DateController _birthOfDateController = DateController();
  final ValueNotifier<FormControl> _valueNotifier = ValueNotifier<FormControl>(const FormControl());

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

    final user = User(
      name: _fullNameController.text,
      birthOfDay: _birthOfDateController.text,
    );

    final result = await saveUseCase.executeWithParams(user);
    return result;
  }

  bool get isAnyProgress => _valueNotifier.value.isFormEmpty;

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
    '$isFormFilled'.log;

    _valueNotifier.value = _valueNotifier.value.copyWith(isFormEmpty: isFormFilled);

    _valueNotifier.value.isFormEmpty.w;
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
