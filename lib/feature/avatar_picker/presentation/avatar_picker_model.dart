part of 'avatar_picker.dart';

mixin _AvatarPickerModel on State<AvatarPicker>, DialogUtil {
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
      await _updatePage();
      if (mounted) {
        await context.router.push(
          UserGeneralInfoView(
            avatar: avatarList[index],
          ),
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

  Future<void> _updatePage() async {
    final pageCase = Locator.sl<PageUseCase>();
    const appModel = AppModel(page: Pages.userGeneralInfo);
    final result = await pageCase.executeWithParams(appModel);
    print("result: $result");
  }
}
