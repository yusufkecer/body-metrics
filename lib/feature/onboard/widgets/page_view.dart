part of '../onboard.dart';

@immutable
final class _PageView extends PageViewModel {
  _PageView({
    super.title,
    super.body,
    Image? super.image,
    PageDecoration decoration = const PageDecoration(
      titleTextStyle: TextStyle(),
      bodyTextStyle: TextStyle(fontSize: 18),
    ),
    BuildContext? context,
  }) {
    decoration = decoration.copyWith(
      titleTextStyle: context?.textTheme.titleMedium ?? decoration.titleTextStyle,
      bodyTextStyle: context?.textTheme.bodyMedium ?? decoration.bodyTextStyle,
    );
  }

  final List<PageViewModel> _pageViewList = [
    _PageView(
      title: LocaleKeys.onboard_onboarding_1_title.tr(),
      body: LocaleKeys.onboard_onboarding_1.tr(),
      image: Image.asset(AssetValue.ob1.value.onboard),
    ),
    _PageView(
      title: LocaleKeys.onboard_onboarding_2_title.tr(),
      body: LocaleKeys.onboard_onboarding_2.tr(),
      image: Image.asset(AssetValue.ob2.value.onboard),
    ),
    _PageView(
      title: LocaleKeys.onboard_onboarding_3_title.tr(),
      body: LocaleKeys.onboard_onboarding_3.tr(),
      image: Image.asset(AssetValue.ob3.value.onboard),
    ),
    _PageView(
      title: LocaleKeys.onboard_onboarding_4_title.tr(),
      body: LocaleKeys.onboard_onboarding_4.tr(),
      image: Image.asset(AssetValue.ob4.value.onboard),
    ),
    _PageView(
      title: LocaleKeys.onboard_onboarding_5.tr(),
      image: Image.asset(AssetValue.ob5.value.onboard),
    ),
  ];
}
