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

  void _onDone() {}

  void _onChange(int value) {
    context.read<OnboardCubit>().updateIndex(value);
  }

  bool get _isEnd => context.watch<OnboardCubit>().state.currentPage != _pageListCount;
}
