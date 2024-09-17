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

    if (!result.isNotNull) {
      pushNewView(const OnboardView());
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
