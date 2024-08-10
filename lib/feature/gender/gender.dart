import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/widgets/gradient_scafflod.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/core/widgets/animated_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
                const HeightPage(),
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
                value: isFemale,
                onChanged: (bool? value) => onChange(value: value, isFemale: true),
                asset: AssetValue.female.value.lottie,
                gender: LocaleKeys.gender_fm.tr(),
                color: ProductColor().pink,
                icon: FontAwesomeIcons.venus,
              ),
              //  Divider(color: context.colorScheme.onSurface),
              GenderAsset(
                value: isMale,
                onChanged: (bool? value) => onChange(value: value, isMale: true),
                asset: AssetValue.male.value.lottie,
                gender: LocaleKeys.gender_ml.tr(),
                color: ProductColor().blue,
                icon: FontAwesomeIcons.mars,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
