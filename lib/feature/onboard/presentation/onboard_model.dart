part of 'onboard.dart';

mixin _OnboardModel on State<_OnboardBody>, _PageViewMixin {
  IntroKey pageController = IntroKey();
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
    pageController.currentState?.dispose();
    super.dispose();
  }

  void _skip() {
    context.read<OnboardCubit>().skip(_pageListCount, pageController);
  }

  Future<void> _onDone() async {
    const entity = AppModel(
      isCompleteOnboard: true,
    );
    final result = await context.read<OnboardCubit>().done(entity);

    if (result) {
      await context.router.pushAndPopUntil(
        const GenderView(),
        predicate: (route) => false,
      );
    }
  }

  void _onChange(int value) {
    context.read<OnboardCubit>().updateIndex(value);
  }

  bool get _isEnd => context.watch<OnboardCubit>().state.currentPage != _pageListCount;
}
