import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'onboard_model.dart';

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
  const _OnboardBody({super.key});

  @override
  State<_OnboardBody> createState() => __OnboardBodyState();
}

class __OnboardBodyState extends State<_OnboardBody> with OnboardModel {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
