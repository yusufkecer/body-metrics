part of 'avatar_picker.dart';

mixin _AvatarPickerModel
    on State<AvatarPicker>, DialogUtil<AvatarPicker>, SaveAppMixin {
  final List<String> avatarList = AssetValue.values.profileImageList;
  late final List<User>? userList;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isChangeProfile) _getAllUsers();
    });

    super.initState();
  }

  Future<void> _getAllUsers() async {
    final locator = Locator.sl<UserUseCase>();

    final users = await locator.execute();

    if (users.isNotNull) {
      showLottieError(LocaleKeys.register_avatar_select_failed);
    }

    setState(() {
      userList = users!.users ?? [];
    });
  }

  Future<void> _addNewProfile(int index) async {
    final user = UserFilters(
      avatar: avatarList[index],
    );

    final avatarUseCase = Locator.sl<SaveAvatarUseCase>();
    final insertId = await avatarUseCase.executeWithParams(user);

    if (insertId == null) {
      showLottieError(LocaleKeys.register_avatar_select_failed);
      return;
    }
    AppUtil.currentUserId = insertId;

    final appModel = AppModel(
      activeUser: insertId,
      page: Pages.userGeneralInfo,
    );

    final result = await _setValues(appModel);

    if (result.isNotNull && mounted) {
      await context.router.pushAndPopUntil(
        UserGeneralInfoView(
          avatar: avatarList[index],
        ),
        predicate: (route) => false,
      );
    } else {
      showLottieError(LocaleKeys.register_avatar_select_failed);
    }
  }

  Future<bool?> _changeProfile(int userId) async {
    AppUtil.currentUserId = userId;

    final appModel = AppModel(
      activeUser: userId,
    );

    final result = await _setValues(appModel);

    if (!result.isNotNull || !mounted) {
      showLottieError(LocaleKeys.change_profile_profile_not_changed);
      return false;
    }

    await context.router.pushAndPopUntil(
      const HomeView(),
      predicate: (route) => false,
    );

    return _setValues(appModel);
  }

  Future<bool?> _setValues(AppModel model) async {
    final locator = Locator.sl<AppUseCase>();

    final result = await locator.executeWithParams(model);

    return result;
  }

  void _tappedAvatar(int index) {
    if (widget.isChangeProfile) {
      _changeProfile(index);
      return;
    }

    _addNewProfile(index);
  }
}
