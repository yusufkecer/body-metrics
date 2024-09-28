import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/presentation/cubit/change_gender_cubit/change_gender.dart';
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

class __GenderViewState extends State<_GenderView> with SavePageMixin, _GenderModel {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.gender_gender_name.tr(),
        action: buildAction(),
      ),
      body: Center(
        child: Padding(
          padding: ProductPadding.ten(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _GenderAsset(
                value: context.watch<GenderCubit>().state.genderValue == GenderValue.female,
                onChanged: ({bool? value}) => onChange(value: value, isFemale: true),
                asset: AssetValue.female.value.lottie,
                gender: LocaleKeys.gender_fm.tr(),
                color: ProductColor().pink,
                icon: ProductIcon.venus.icon,
              ),
              _GenderAsset(
                value: context.watch<GenderCubit>().state.genderValue == GenderValue.male,
                onChanged: ({bool? value}) => onChange(value: value, isMale: true),
                asset: AssetValue.male.value.lottie,
                gender: LocaleKeys.gender_ml.tr(),
                color: ProductColor().blue,
                icon: ProductIcon.mars.icon,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAction() {
    return isSelected()
        ? ColorfulTextButton(
            text: LocaleKeys.cont.tr(),
            onTap: _pushToHeight,
          )
        : const SizedBox.shrink();
  }
}
