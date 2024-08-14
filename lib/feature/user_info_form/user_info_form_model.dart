part of 'user_info_form.dart';

mixin UserInfoFormModel on State<UserInfoForm> {
  TextEditingController fullNameController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  void onPressed() {}
}
