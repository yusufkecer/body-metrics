part of 'splash.dart';

mixin _SplashModel on State<_SplashBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncInitState();
    });
    super.initState();
  }

  Future<void> _asyncInitState() async {
    // final cubit = context.read<SplashCubit>();
    // final result = await cubit.init();
    // // final activeUser = result.activeUser;
    // final isCompleteOnboarding = result.isCompleteOnboarding;

    // if ((isCompleteOnboarding ?? false) && mounted) {
    //   await context.pushRoute(AvatarPickerView());
    // } else if (mounted) {
    //   await context.pushRoute(const GenderView());
    // }
    // FlutterNativeSplash.remove();
    final impCache = Locator.sl<ImpCache>();
    // Database? db;
    // db = await impCache.initializeDatabase(
    //   initTable: () => initializeTables(impCache, db),
    // );
    await impCache.initializeDatabase();
    await impCache.getTables();
  }

  Future<void> initializeTables(ImpCache impCache, Database? db) async {
    final appCache = Locator.sl<AppCache>();
    final bmiCache = Locator.sl<BMICache>();
    final userCache = Locator.sl<UserCache>();

    if (db == null) {
      throw ArgumentError.notNull('db is null');
    }
    'initializeTables'.log;
    await appCache.initializeTable(db, impCache.version);
    await bmiCache.initializeTable(db, impCache.version);
    await userCache.initializeTable(db, impCache.version);
    await impCache.getTables();

    // await impCache.closeDb();
  }
}
