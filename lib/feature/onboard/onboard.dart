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
      appBar: AppBar(
        title: Text(LocaleKeys.onboard_welcome.tr()),
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

class __OnboardBodyState extends State<_OnboardBody> with OnboardModel {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: _PageView(context: context)._pageViewList,
      showSkipButton: true,
      skip: const Icon(Icons.skip_next),
      next: const Text('Next'),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w700)),
      onDone: () {
        // On Done button pressed
      },
      onSkip: () {
        // On Skip button pressed
      },
      dotsDecorator: DotsDecorator(
        size: const Size.square(10),
        activeSize: const Size(20, 10),
        activeColor: Theme.of(context).colorScheme.secondary,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
