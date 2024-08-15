part of 'user_info_form.dart';

mixin UserInfoFormModel on State<UserInfoForm>, DialogUtil {
  TextEditingController fullNameController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  void onPressed() {
    if (fullNameController.text.isEmpty) {
      showLottieError(context, LocaleKeys.register_name_empty.tr(), '');
    }
  }
}
