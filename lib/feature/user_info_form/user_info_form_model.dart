part of 'user_info_form.dart';

mixin UserInfoFormModel on State<UserInfoForm>, DialogUtil {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthofDateController = TextEditingController();
  final ValueNotifier<UserInfoFormEntity> _valueNotifier =
      ValueNotifier<UserInfoFormEntity>(const UserInfoFormEntity());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _fullNameController.dispose();
    _birthofDateController.dispose();
    _valueNotifier.dispose();
    super.dispose();
  }

  Future<void> _onPressed() async {
    if (_fullNameController.text.isEmpty) {
      if (!mounted) return;
      showLottieError(LocaleKeys.register_name_empty.tr());
      return;
    }
    final userInfoRepository = Locator.sl<GetUserRepository>();

    final saveUseCase = Locator.sl<SaveUseCase>(param1: userInfoRepository);

    final user = User(
      name: _fullNameController.text,
      birthOfDay: _birthofDateController.text,
    );

    await saveUseCase.execute(user);
  }

  bool get isAnyProgress => _valueNotifier.value.isFormEmpty;

  void _openDatePicker() {
    showDatePicker(
      barrierColor: ProductColor().seedColor.withOpacity(0.4),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        _fullNameController.text = value.toString();
      }
    });
  }

  void _formListener() {
    '${checkFields()}'.log;

    _valueNotifier.value.isFormEmpty.w;

    _valueNotifier.value = _valueNotifier.value.copyWith(isFormEmpty: checkFields());

    _valueNotifier.value.isFormEmpty.w;
  }

  bool checkFields() {
    return _fullNameController.text.isNotEmpty || _birthofDateController.text.isNotEmpty;
  }
}
