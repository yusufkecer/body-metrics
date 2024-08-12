import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/feature/gender/cubit/gender_select/change_gender.dart';
import 'package:bmicalculator/injection/locator.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

part 'gender_model.dart';
part 'widgets/gender_asset.dart';

@RoutePage(name: 'GenderView')
class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> with GenderModel {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenderCubit(),
      child: BlocBuilder<GenderCubit, GenderState>(
        builder: (context, snapshot) {
          return GradientScafflod(
            appBar: AppBar(
              title: Text(LocaleKeys.gender_gender_name.tr()),
              actions: [
                if (isMale != null || isFemale != null)
                  ColorfulText(
                    colors: ProductColor().animatedColorList,
                    speed: Durations.long3,
                    text: LocaleKeys.cont.tr(),
                    onTap: () => context.router.push(
                      HeightView(isFemale: isFemale!),
                    ),
                  ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const ProductPadding.ten(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GenderAsset(
                      value: false,
                      onChanged: (bool? value) {
                        context.read<GenderCubit>().changeGender2();
                      },
                      asset: AssetValue.female.value.lottie,
                      gender: LocaleKeys.gender_fm.tr(),
                      color: ProductColor().pink,
                      icon: FontAwesomeIcons.venus,
                    ),
                    // GenderAsset(
                    //   value: context.watch<GenderCubit>().genderValue == GenderValue.male,
                    //   onChanged: (bool? value) => onChange(value: value, isMale: true),
                    //   asset: AssetValue.male.value.lottie,
                    //   gender: LocaleKeys.gender_ml.tr(),
                    //   color: ProductColor().blue,
                    //   icon: FontAwesomeIcons.mars,
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
