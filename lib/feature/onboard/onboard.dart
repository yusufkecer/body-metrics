import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/onboard/cubit/onboard_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

part 'onboard_model.dart';
part 'widgets/page_view.dart';

@immutable
@RoutePage(name: 'OnboardView')
final class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<OnboardCubit>(),
      child: const _OnboardBody(),
    );
  }
}

class _OnboardBody extends StatefulWidget {
  const _OnboardBody();

  @override
  State<_OnboardBody> createState() => __OnboardBodyState();
}

class __OnboardBodyState extends State<_OnboardBody> with _PageViewMixin, _OnboardModel {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: CustomAppBar(
        title: LocaleKeys.onboard_welcome.tr(),
        action: _isEnd ? colorfulbttn() : const SizedBox.shrink(),
      ),
      body: Center(
        child: IntroductionScreen(
          key: pageController,
          onChange: _onChange,
          pages: _pageViewList,
          showBackButton: true,
          next: Icon(ProductIcon.arrowRight.icon),
          done: Icon(ProductIcon.check.icon),
          back: Icon(ProductIcon.arrowLeft.icon),
          onDone: _onDone,
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
        ),
      ),
    );
  }

  ColorfulText colorfulbttn() {
    return ColorfulText(
      colors: ProductColor().animatedColorList,
      speed: Durations.long3,
      text: LocaleKeys.onboard_skip.tr(),
      onTap: _skip,
    );
  }
}
