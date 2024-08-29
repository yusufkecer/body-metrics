part of 'onboard.dart';

mixin _OnboardModel on State<_OnboardBody>, _PageViewMixin {
  void _skip() {
    print(context.read<OnboardCubit>().state.introKey);
    Locator.sl<OnboardCubit>().skip(_pageViewList.length - 1);
  }
}
