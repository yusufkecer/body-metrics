import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/presentation/cubit/gender_cubit/gender_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

part 'gender_model.dart';
part 'widgets/gender_asset.dart';

@RoutePage(name: 'GenderView')
@immutable
final class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<GenderCubit>(),
      child: const _GenderView(),
    );
  }
}

@immutable
final class _GenderView extends StatefulWidget {
  const _GenderView();

  @override
  State<_GenderView> createState() => __GenderViewState();
}

class __GenderViewState extends State<_GenderView>
    with DialogUtil<_GenderView>, SaveAppMixin, _GenderModel {
  @override
  Widget build(BuildContext context) {
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
            VerticalSpace.l(),
            Expanded(
              child: Padding(
                padding: ProductPadding.horizontalTwentyFour(),
                child: AuthFormLayout(
                  title: LocaleKeys.gender_gender_name.tr(),
                  child: BlocBuilder<GenderCubit, GenderState>(
                    builder: (context, state) {
                      final isFemale =
                          state is GenderSelected &&
                          state.genderValue == GenderValue.female;
                      final isMale =
                          state is GenderSelected &&
                          state.genderValue == GenderValue.male;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _GenderAsset(
                            value: isFemale,
                            onChanged: (value) => onChange(GenderValue.female),
                            asset: AssetValue.female.value.lottie,
                            gender: LocaleKeys.gender_fm,
                            color: ProductColor.instance.pink,
                            icon: ProductIcon.venus.icon,
                          ),
                          VerticalSpace.m(),
                          _GenderAsset(
                            value: isMale,
                            onChanged: (value) => onChange(GenderValue.male),
                            asset: AssetValue.male.value.lottie,
                            gender: LocaleKeys.gender_ml,
                            color: ProductColor.instance.blue,
                            icon: ProductIcon.mars.icon,
                          ),
                          VerticalSpace.l(),
                          Opacity(
                            opacity: selectedGender.isNotNull ? 1 : 0.45,
                            child: IgnorePointer(
                              ignoring: selectedGender.isNull,
                              child: CustomFilled(
                                text: LocaleKeys.cont,
                                onPressed: _pushToHeight,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
