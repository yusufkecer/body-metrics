part of 'user_info_form.dart';

mixin UserInfoFormModel on State<UserInfoForm>, DialogUtil {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthDayController.dispose();
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

    const user = UserFilters(
      name: 'name',
    );

    await saveUseCase.execute(user);
  }

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
}
