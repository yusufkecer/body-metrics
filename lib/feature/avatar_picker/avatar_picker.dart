part of 'avatar_picker_model.dart';

mixin AvatarPickerModel on State<AvatarPicker> {
  final List<String> avatarList = AssetValue.values.profileImageList;

  void onTapProfileImage(int index) {
    context.pushRoute(const AvatarPickerView());
  }
}
