import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/save_height_cubit/save_height_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

part 'enum/height_values.dart';
part 'height_picker_model.dart';
part 'widgets/ruler.dart';

@RoutePage(name: 'HeightView')
@immutable
final class HeightPicker extends StatelessWidget {
  const HeightPicker({required this.gender, super.key});

  final GenderValue gender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<HeightSelectorCubit>(),
      child: Builder(
        builder: (context) {
          return _HeightBody(isFemale: gender.isFemale());
        },
      ),
    );
  }
}

@immutable
final class _HeightBody extends StatefulWidget {
  const _HeightBody({required this.isFemale});

  final bool isFemale;

  @override
  State<_HeightBody> createState() => _HeightBodyState();
}

class _HeightBodyState extends State<_HeightBody>
    with SaveAppMixin, DialogUtil<_HeightBody>, _HeightModel {
  @override
  Widget build(BuildContext context) {
    cubit = context.watch<HeightSelectorCubit>();
    if (cubit == null) {
      return const CustomError();
    }

    final selectedHeight = cubit!.state.userHeight ?? _minValue;

    return GradientScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const ProductPadding.authForm(),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.router.maybePop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ProductColor.instance.whiteAlpha20,
                        borderRadius: const ProductRadius.twelve(),
                        border: Border.all(
                          color: ProductColor.instance.whiteAlpha40,
                        ),
                      ),
                      child: Icon(
                        ProductIcon.backArrow.icon,
                        color: ProductColor.instance.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppUtil.appName,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: ProductColor.instance.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  HorizontalSpace.s(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProductColor.instance.whiteAlpha20,
                      border: Border.all(
                        color: ProductColor.instance.whiteAlpha50,
                      ),
                    ),
                    child: Icon(
                      ProductIcon.heartMonitor.icon,
                      color: ProductColor.instance.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpace.s(),
            Expanded(
              child: Padding(
                padding: ProductPadding.horizontalTwentyFour(),
                child: AuthFormLayout(
                  title: LocaleKeys.height_select_height.tr(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ProductColor.instance.whiteAlpha20,
                            borderRadius: const ProductRadius.twelve(),
                            border: Border.all(
                              color: ProductColor.instance.whiteAlpha40,
                            ),
                          ),
                          child: Text(
                            '$selectedHeight cm',
                            style: context.textTheme.displaySmall?.copyWith(
                              color: ProductColor.instance.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                      VerticalSpace.s(),
                      SizedBox(
                        height: context.height * 0.44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 8),
                            Expanded(
                              child: RepaintBoundary(
                                child: Lottie.asset(
                                  _lottie!.lottie,
                                  height: cubit!.state.height,
                                ),
                              ),
                            ),
                            _Ruler(
                              pageController: _pageController,
                              maxValue: _maxValue,
                              minValue: _minValue,
                              selectedHeight: selectedHeight,
                              height: context.height * 0.42,
                            ),
                          ],
                        ),
                      ),
                      VerticalSpace.m(),
                      CustomFilled(text: LocaleKeys.cont, onPressed: _onSaved),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
