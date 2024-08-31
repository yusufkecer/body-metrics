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

    if (!result.isNotNull) {
      pushNewView(const OnboardView());
    } else {
      pushNewView(AvatarPickerView());
    }

    FlutterNativeSplash.remove();
  }

  Future<void> initializeTables(ImpCache impCache) async {
    final appCache = Locator.sl<AppCache>();
    final bmiCache = Locator.sl<BmiCache>();
    final userCache = Locator.sl<UserCache>();

    if (impCache.db == null) {
      showLottieError(LocaleKeys.dialog_general_error.tr());

      throw ArgumentError.notNull('db is null');
    }

    'initializing tables'.log;

    await appCache.initializeTable(impCache.db!, impCache.version);
    await userCache.initializeTable(impCache.db!, impCache.version);
    await bmiCache.initializeTable(impCache.db!, impCache.version);
  }

  void pushNewView(PageRouteInfo arguments) {
    context.router.pushAndPopUntil(
      arguments,
      predicate: (route) => false,
    );
  }
}
