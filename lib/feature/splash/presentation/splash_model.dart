part of 'splash.dart';

mixin _SplashModel on State<Splash>, DialogUtil<Splash> {
  late final SplashAppUseCase _splashAppUseCase =
      Locator.sl<SplashAppUseCase>();

  late final ImpCache _impCache = Locator.sl<ImpCache>();
  late final AuthService _authService = Locator.sl<AuthService>();
  late final SyncLocalDataUseCase _syncLocalDataUseCase =
      Locator.sl<SyncLocalDataUseCase>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _asyncInitState());
  }

  Future<void> _asyncInitState() async {
    await _initializeDatabase();
    await _handleAppInitialization();
    await _restoreAuthSession();
    await _retryPendingSync();

    if (!mounted) return;

    final result = await _splashAppUseCase.executeWithParams();

    _setAppState(result);
    _navigateToAppropriatePage(result);

    FlutterNativeSplash.remove();
  }

  Future<void> _initializeDatabase() async {
    await _impCache.initializeDatabase();
    //  await _impCache.deleteDb();
  }

  Future<void> _handleAppInitialization() async {
    await _initializeTables();
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

  Future<void> _restoreAuthSession() async {
    try {
      await _authService.restoreSessionFromCache();
      'Session restore completed'.log();
    } catch (e) {
      'Session restore failed: $e'.e();
    }
  }

  Future<void> _retryPendingSync() async {
    try {
      await _syncLocalDataUseCase.restoreAndAttemptSync();
    } catch (e) {
      'Splash: background sync attempt failed — $e'.e();
    }
  }

  void _setAppState(AppModel? result) {
    'currentUserId ${jsonEncode(result)}'.log();
    AppUtil.currentUserId = result?.activeUser;
  }

  void _navigateToAppropriatePage(AppModel? result) {
    if (result?.activeUser != null) {
      _pushNewView(const HomeView());
    } else if (result?.isCompleteOnboard ?? false) {
      _pushNewView(const AvatarPickerView());
    } else {
      _pushNewView(const OnboardView());
    }
  }

  void _pushNewView(PageRouteInfo arguments) {
    context.router.pushAndPopUntil(arguments, predicate: (route) => false);
  }
}
