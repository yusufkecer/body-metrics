part of 'avatar_picker.dart';

mixin _AvatarPickerModel
    on State<AvatarPicker>, DialogUtil<AvatarPicker>, SaveAppMixin {
  final List<String> avatarList = AssetValue.values.profileImageList;
  bool _isAuthCompleted = false;

  Future<void> _addNewProfile(int index) async {
    final user = UserFilters(avatar: avatarList[index]);

    final avatarUseCase = Locator.sl<SaveAvatarUseCase>();
    final insertId = await avatarUseCase.executeWithParams(params: user);

    if (insertId == null) {
      showLottieError(LocaleKeys.register_avatar_select_failed);
      if (!mounted) return;

      await context.router.pushAndPopUntil(
        const HomeView(),
        predicate: (route) => false,
      );
      return;
    }

    await Locator.sl<SetIdUseCase>().executeWithParams(params: insertId);

    final appModel = AppModel(
      activeUser: insertId,
      page: Pages.userGeneralInfo,
    );

    final result = await _setValues(appModel);

    if (result.isNotNull) {
      if (mounted) {
        await context.router.pushAndPopUntil(
          UserGeneralInfoView(avatar: avatarList[index]),
          predicate: (route) => false,
        );
      }
    } else {
      if (mounted) {
        showLottieError(LocaleKeys.register_avatar_select_failed);
      }
    }
  }

  Future<bool?> _setValues(AppModel model) async {
    final saveAppUseCase = Locator.sl<SaveAppUseCase>();

    final result = await saveAppUseCase.executeWithParams(params: model);

    return result;
  }

  Future<void> _tappedAvatar(int index) async {
    await _addNewProfile(index);
  }
}
