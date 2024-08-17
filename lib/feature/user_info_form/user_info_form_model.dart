part of 'user_info_form.dart';

mixin UserInfoFormModel on State<UserInfoForm>, DialogUtil {
  final _fullNameController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> onPressed() async {
    // if (_fullNameController.text.isEmpty) {
    //   if (!mounted) return;
    //   showLottieError(context, LocaleKeys.register_name_empty.tr(), '');
    //   return;
    // }
    final userInfoRepository = Locator.sl<UserRepository>();

    final saveUseCase = Locator.sl<SaveUseCase>(param1: userInfoRepository);

    final user = User(
      name: _fullNameController.text,
      avatar: widget.avatar,
    );

    await saveUseCase.execute(user.toJson());
  }
}
