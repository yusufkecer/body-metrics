import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
part 'height_model.dart';

@RoutePage(name: 'HeightPage')
class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        title: Text(LocaleKeys.gender_select_gender.tr()),
        actions: [
          ColorfulText(
              colors: ProductColor().animatedColorList,
              speed: Durations.long3,
              text: LocaleKeys.cont.tr(),
              onTap: () {}),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const ProductPadding.ten(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(LocaleKeys.height_height_name.tr()),
              HorizantalSpace.xs(),
              // HeightSlider(
              //   value: height,
              //   onChanged: (double value) => setState(() => height = value),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
