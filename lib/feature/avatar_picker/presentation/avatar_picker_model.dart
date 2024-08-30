part of 'avatar_picker.dart';

mixin _AvatarPickerModel on State<AvatarPicker> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  final List<String> avatarList = AssetValue.values.profileImageList;

  void _addNewProfile(int index) {
    context.pushRoute(UserInfoFormView(avatar: avatarList[index]));
  }

  void _onTapSkip() {
    context.pushRoute(const GenderView());
  }
}
