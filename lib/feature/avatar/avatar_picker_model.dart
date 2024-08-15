part of 'avatar_picker.dart';

mixin AvatarPickerModel on State<AvatarPicker> {
  final List<String> avatarList = AssetValue.values.profileImageList;

  void onTapProfileImage(int index) {
    context.pushRoute(const AvatarPickerView());
  }
}
