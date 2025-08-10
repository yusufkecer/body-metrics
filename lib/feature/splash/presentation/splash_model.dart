part of 'splash.dart';

mixin _SplashModel on State<_SplashBody>, DialogUtil {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncInitState();
    });
    super.initState();
  }

  Future<void> _asyncInitState() async {
    final impCache = Locator.sl<ImpCache>();

    await impCache.initializeDatabase();
    // impCache.deleteDb();
    // return;

    final isExist = await impCache.isExist();
    if (!isExist) {
      await initializeTables(impCache);
    }

    if (!mounted) return;
    final cubit = context.read<SplashCubit>();
    final result = await cubit.init();
    'page result ${result?.page}'.log();

    AppUtil.currentUserId = result?.activeUser;
    AppUtil.lastPage = result?.page;

    await _checkPage(result);

    FlutterNativeSplash.remove();
  }

  Future<void> initializeTables(ImpCache impCache) async {
    if (impCache.db == null) {
      showLottieError(LocaleKeys.dialog_general_error.tr());

      throw ArgumentError.notNull('db is null');
    }

    'initializing tables'.log();

    await Locator.sl<AppCache>().initializeTable(impCache.db!, impCache.version);
    await Locator.sl<UserMetricsCache>().initializeTable(impCache.db!, impCache.version);
    await Locator.sl<UserCache>().initializeTable(impCache.db!, impCache.version);
  }

  void pushNewView(PageRouteInfo arguments) {
    context.router.pushAndPopUntil(
      arguments,
      predicate: (route) => false,
    );
  }

  Future<void> _checkPage(AppModel? result) async {
    final cubit = context.read<SplashCubit>();
    if (result.isNull) {
      pushNewView(const OnboardView());
    } else if (result?.page == Pages.genderPage) {
      pushNewView(const GenderView());
    } else if (result?.page == Pages.avatarPage) {
      pushNewView(AvatarPickerView());
    } else if (result?.page == Pages.userGeneralInfo) {
      final params = ParamsEntity(
        columns: [UserCacheColumns.avatar.value],
        filters: {UserCacheColumns.id.value: AppUtil.currentUserId},
      );

      final user = await cubit.userValues(params);
      if (user.isNullOrEmpty) return;

      pushNewView(UserGeneralInfoView(avatar: user!.avatar!));
    } else if (result?.page == Pages.heightPage) {
      final params = ParamsEntity(
        columns: [UserCacheColumns.gender.value],
        filters: {UserCacheColumns.id.value: AppUtil.currentUserId},
      );

      final user = await cubit.userValues(params);
      if (user.isNullOrEmpty) return;
      pushNewView(HeightView(gender: user!.gender!));
    } else if (result?.page == Pages.weightPage) {
      pushNewView(const WeightView());
    } else {
      pushNewView(const HomeView());
    }
  }
}
