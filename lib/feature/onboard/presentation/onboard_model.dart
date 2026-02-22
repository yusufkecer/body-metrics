part of 'onboard.dart';

mixin _OnboardModel on State<_OnboardBody>, _PageViewMixin, SaveAppMixin {
  final IntroKey _pageController = IntroKey();
  int get _pageListCount => _pageViewList.length - 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardCubit>().updateIndex(0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.currentState?.dispose();
    super.dispose();
  }

  void _skip() {
    context.read<OnboardCubit>().skip(_pageListCount, _pageController);
  }

  Future<void> _onDone() async {
    const entity = AppModel(isCompleteOnboard: true);
    final result = await context.read<OnboardCubit>().done(entity);
    await saveApp(Pages.avatarPage);
    if (result && mounted) {
      await context.router.pushAndPopUntil(
        const AvatarPickerView(),
        predicate: (route) => false,
      );
    }
  }

  void _onChange(int value) {
    context.read<OnboardCubit>().updateIndex(value);
  }

  bool get _isEnd =>
      context.watch<OnboardCubit>().state.currentPage != _pageListCount;
}
