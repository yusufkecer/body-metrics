part of 'avatar_picker.dart';

mixin AvatarPickerModel on State<AvatarPicker> {
  final List<String> avatarList = AssetValue.values.profileImageList;

  void addNewProfile(int index) {
    context.pushRoute(UserInfoFormView(avatar: avatarList[index]));
  }

  void onTapSkip() {
    context.pushRoute(const GenderView());
  }
}
