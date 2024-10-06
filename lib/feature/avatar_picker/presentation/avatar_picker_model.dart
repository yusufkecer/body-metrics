part of 'avatar_picker.dart';

mixin _AvatarPickerModel on State<AvatarPicker>, DialogUtil, SaveAppMixin {
  final List<String> avatarList = AssetValue.values.profileImageList;

  void _onTapSkip() {
    context.pushRoute(const GenderView());
  }

  Future<void> _addNewProfile(int index) async {
    final user = UserFilters(
      avatar: avatarList[index],
    );

    final avatarUseCase = Locator.sl<SaveAvatarUseCase>();
    final insertId = await avatarUseCase.executeWithParams(user);

    if (insertId == null) {
      showLottieError(LocaleKeys.register_avatar_select_failed.tr());
      return;
    }

    final result = await setNewUserId(insertId);

    if (result.isNotNull) {
      if (mounted) {
        await context.router.pushAndPopUntil(
          UserGeneralInfoView(
            avatar: avatarList[index],
          ),
          predicate: (route) => false,
        );
      }
    } else {
      showLottieError(LocaleKeys.register_avatar_select_failed.tr());
    }
  }

  Future<bool?> setNewUserId(int userId) async {
    AppUtil.currentUserId = userId;

    final locator = Locator.sl<AppUseCase>();

    final model = AppModel(
      activeUser: userId,
      page: Pages.userGeneralInfo,
    );

    final result = await locator.executeWithParams(model);
    return result;
  }
}
