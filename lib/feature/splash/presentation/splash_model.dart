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

    final isExist = await impCache.isExist();
    if (!isExist) {
      await initializeTables(impCache);
    }

    if (!mounted) return;
    final cubit = context.read<SplashCubit>();
    final result = await cubit.init();
    await impCache.closeDb();

    'result: $result'.log;

    AppUtil.currentUserId = result?.activeUser;
    AppUtil.lastPage = result?.page;

    if (result.isNull) {
      pushNewView(const OnboardView());
    } else if (result?.page == Pages.genderPage) {
      pushNewView(const GenderView());
    } else if (result?.page == Pages.avatarPage) {
      pushNewView(AvatarPickerView());
    } else if (result?.page == Pages.createProfilePage) {
      final getUserProfileImage = await Locator.sl<UserCache>().;
      pushNewView(UserGeneralInfoView(avatar: getUserProfileImage ?? ''));
    } else if (result?.page == Pages.heightPage) {
      pushNewView(HeightView(isFemale: false)); //TODO: change this
    } else if (result?.page == Pages.weightPage) {
      pushNewView(const WeightView());
    } else {
      pushNewView(const HomeView());
    }

    FlutterNativeSplash.remove();
  }

  Future<void> initializeTables(ImpCache impCache) async {
    if (impCache.db == null) {
      showLottieError(LocaleKeys.dialog_general_error.tr());

      throw ArgumentError.notNull('db is null');
    }

    'initializing tables'.log;

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
}
