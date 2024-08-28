import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

part 'onboard_model.dart';
part 'widgets/page_view.dart';

@immutable
@RoutePage(name: 'OnboardView')
final class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: CustomAppBar(
        title: LocaleKeys.onboard_welcome.tr(),
      ),
      body: const _OnboardBody(),
    );
  }
}

class _OnboardBody extends StatefulWidget {
  const _OnboardBody();

  @override
  State<_OnboardBody> createState() => __OnboardBodyState();
}

class __OnboardBodyState extends State<_OnboardBody> with OnboardModel, _PageViewMixin {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: _pageViewList,
      showBackButton: true,
      next: Icon(ProductIcon.arrowRight.icon),
      done: Icon(ProductIcon.check.icon),
      back: Icon(ProductIcon.arrowLeft.icon),
      onDone: () {},
      baseBtnStyle: BaseTheme().onboardButton,
      dotsDecorator: DotsDecorator(
        size: const CustomSize.activeDot(),
        activeSize: const CustomSize.dots(),
        activeColor: context.colorScheme.surfaceBright,
        color: ProductColor().seedColor,
        activeShape: const RoundedRectangleBorder(
          borderRadius: ProductRadius.twentyFive(),
        ),
      ),
    );
  }
}
