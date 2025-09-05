part of 'splash.dart';

mixin _SplashModel on State<Splash>, DialogUtil<Splash> {
  late final SplashAppUseCase _splashAppUseCase = Locator.sl<SplashAppUseCase>();
  late final SplashUserUseCase _splashUserUseCase = Locator.sl<SplashUserUseCase>();

  late final ImpCache _impCache = Locator.sl<ImpCache>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _asyncInitState());
  }

  Future<void> _asyncInitState() async {
    await _initializeDatabase();
    await _handleAppInitialization();

    if (!mounted) return;

    final result = await _splashAppUseCase.executeWithParams();
    'page result ${result?.page}'.log();

    _setAppState(result);
    await _navigateToAppropriatePage(result);

    FlutterNativeSplash.remove();
  }

  Future<void> _initializeDatabase() async {
    await _impCache.initializeDatabase();
    // await _impCache.deleteDb();
  }

  Future<void> _handleAppInitialization() async {
    final isExist = await _impCache.isExist();
    if (!isExist) {
      await _initializeTables();
    }
  }

  Future<void> _initializeTables() async {
    if (_impCache.db == null) {
      showLottieError(LocaleKeys.dialog_general_error);
      throw ArgumentError.notNull('db is null');
    }

    'initializing tables'.log();

    final db = _impCache.db!;
    final version = _impCache.version;

    await Future.wait([
      Locator.sl<AppCache>().initializeTable(db, version),
      Locator.sl<UserMetricsCache>().initializeTable(db, version),
      Locator.sl<UserCache>().initializeTable(db, version),
    ]);
  }

  void _setAppState(AppModel? result) {
    'currentUserId ${jsonEncode(result)}'.log();
    AppUtil.currentUserId = result?.activeUser;
    AppUtil.lastPage = result?.page;
  }

  Future<void> _navigateToAppropriatePage(AppModel? result) async {
    if (result == null) {
      _pushNewView(const OnboardView());
      return;
    }

    final page = result.page;
    if (page == null) {
      _pushNewView(const OnboardView());
      return;
    }

    switch (page) {
      case Pages.genderPage:
        _pushNewView(const GenderView());
      case Pages.avatarPage:
        _pushNewView(AvatarPickerView());
      case Pages.userGeneralInfo:
        await _navigateToUserGeneralInfo();
      case Pages.heightPage:
        await _navigateToHeightPage();
      case Pages.weightPage:
        _pushNewView(const WeightView());
      case Pages.homePage:
        _pushNewView(const HomeView());
      case Pages.onboardPage:
        _pushNewView(const OnboardView());
    }
  }

  Future<void> _navigateToUserGeneralInfo() async {
    final user = await _getUserWithAvatar();
    if (user != null && user.avatar != null) {
      _pushNewView(UserGeneralInfoView(avatar: user.avatar!));
    }
  }

  Future<void> _navigateToHeightPage() async {
    final user = await _getUserWithGender();
    if (user != null && user.gender != null) {
      _pushNewView(HeightView(gender: user.gender!));
    }
  }

  Future<User?> _getUserWithAvatar() async {
    final params = ParamsEntity(
      columns: [UserCacheColumns.avatar.value],
      filters: {UserCacheColumns.id.value: AppUtil.currentUserId},
    );
    return _splashUserUseCase.executeWithParams(params: params);
  }

  Future<User?> _getUserWithGender() async {
    final params = ParamsEntity(
      columns: [UserCacheColumns.gender.value],
      filters: {UserCacheColumns.id.value: AppUtil.currentUserId},
    );
    return _splashUserUseCase.executeWithParams(params: params);
  }

  void _pushNewView(PageRouteInfo arguments) {
    context.router.pushAndPopUntil(
      arguments,
      predicate: (route) => false,
    );
  }
}
