part of 'profile_image_picker.dart';

mixin ProfileImagePickerModel on State<ProfileImagePicker> {
  final List<String> profileImages = AssetValue.values.profileImageList;

  void onTapProfileImage(int index) {
    context.pushRoute(UserInfoFormView(image: profileImages[index]));
  }
}
