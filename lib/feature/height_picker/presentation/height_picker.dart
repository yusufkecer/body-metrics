import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';

part 'cubit/height_picker_cubit.dart';
part 'cubit/height_picker_state.dart';
part 'height_picker_model.dart';
part 'widgets/ruler.dart';

@RoutePage(name: 'HeightView')
@immutable
final class Height extends StatelessWidget {
  final bool isFemale;
  const Height({
    required this.isFemale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<HeightSelectorCubit>(),
      child: GradientScaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.height_select_height.tr(),
          action: ColorfulText(
            text: LocaleKeys.cont.tr(),
            onTap: () {
              context.pushRoute(const WeightView());
            },
          ),
        ),
        body: _HeightBody(
          isFemale: isFemale,
        ),
      ),
    );
  }
}

@immutable
final class _HeightBody extends StatefulWidget {
  final bool isFemale;
  const _HeightBody({
    required this.isFemale,
  });

  @override
  State<_HeightBody> createState() => _HeightBodyState();
}

class _HeightBodyState extends State<_HeightBody> with _HeightModel {
  @override
  Widget build(BuildContext context) {
    cubit = context.watch<HeightSelectorCubit>();

    if (cubit == null) {
      return const CustomError();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        Lottie.asset(
          _lottie!.lottie,
          height: cubit!.state._height,
        ),
        _Ruler(
          pageController: _pageController,
          maxValue: _maxValue,
          minValue: _minValue,
          selectedHeight: cubit!.state._page,
        ),
      ],
    );
  }
}