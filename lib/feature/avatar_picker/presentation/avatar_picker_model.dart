part of 'avatar_picker.dart';

mixin _AvatarPickerModel on State<AvatarPicker>, DialogUtil, SavePageMixin {
  final List<String> avatarList = AssetValue.values.profileImageList;

  void _onTapSkip() {
    context.pushRoute(const GenderView());
  }

  Future<void> _addNewProfile(int index) async {
    final user = UserFilters(
      avatar: avatarList[index],
    );

    final avatarUseCase = Locator.sl<SaveAvatarUseCase>();
    final result = await avatarUseCase.executeWithParams(user);

    if (result.isNotNull && result!) {
      await setPage(Pages.userGeneralInfo);
      if (mounted) {
        await context.router.pushAndPopUntil(
          UserGeneralInfoView(
            avatar: avatarList[index],
          ),
          predicate: (route) => false,
        );
      }
    } else {
      await _continueNotRegistered();
    }
  }

  Future<void> _continueNotRegistered() async {
    final result = await confirmDialog(LocaleKeys.register_avatar_select_failed.tr());

    if ((result.isNullOrEmpty || !result!) && !mounted) {
      return;
    }

    await context.router.push(const GenderView());
  }
}
