part of 'avatar_picker.dart';

mixin _AvatarPickerModel on State<AvatarPicker>, DialogUtil<AvatarPicker>, SaveAppMixin {
  final List<String> avatarList = AssetValue.values.profileImageList;
  List<User> _userList = const [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isChangeProfile) _getAllUsers();
    });

    super.initState();
  }

  Future<void> _getAllUsers() async {
    final usersUseCase = Locator.sl<UserUseCaseImpl>();

    final users = await usersUseCase.getAllUsers();

    if (users == null) {
      showLottieError(LocaleKeys.register_avatar_select_failed);
      return;
    }

    _userList = users.users ?? [];
  }

  Future<void> _addNewProfile(int index) async {
    final user = UserFilters(
      avatar: avatarList[index],
    );

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

  Future<bool?> _changeProfileByIndex(int index) async {
    if (_userList.isEmpty) {
      await _getAllUsers();
    }

    if (_userList.isEmpty || index >= _userList.length) {
      showLottieError(LocaleKeys.change_profile_profile_not_changed);
      return false;
    }

    final userId = _userList[index].id;
    if (userId == null) {
      showLottieError(LocaleKeys.change_profile_profile_not_changed);
      return false;
    }


    await Locator.sl<SetIdUseCase>().executeWithParams(params: userId);

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

    return result;
  }

  Future<bool?> _setValues(AppModel model) async {
    final saveAppUseCase = Locator.sl<SaveAppUseCase>();

    final result = await saveAppUseCase.executeWithParams(params: model);

    return result;
  }

  void _tappedAvatar(int index) {
    if (widget.isChangeProfile) {
      _changeProfileByIndex(index);
      return;
    }

    _addNewProfile(index);
  }
}
