part of 'splash.dart';

mixin _SplashModel on State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncInitState();
    });
    super.initState();
  }

  Future<void> _asyncInitState() async {
    final cubit = context.read<SplashCubit>();
    final result = await cubit.init();
    // final activeUser = result.activeUser;
    final isCompleteOnboarding = result.isCompleteOnboarding;

    if ((isCompleteOnboarding ?? false) && mounted) {
      await context.pushRoute(AvatarPickerView());
    }
  }
}
