import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/feature/height/widgets/ruler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

part 'height_model.dart';

@RoutePage(name: 'HeightView')
class Height extends StatefulWidget {
  final bool isFemale;
  const Height({
    required this.isFemale,
    super.key,
  });

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> with HeightModel {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        title: Text(LocaleKeys.gender_select_gender.tr()),
        actions: [
          ColorfulText(
            colors: ProductColor().animatedColorList,
            speed: Durations.long3,
            text: LocaleKeys.cont.tr(),
            onTap: () {},
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Lottie.asset(_lottie!.lottie),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Ruler(
                      pageController: _pageController,
                      maxValue: _maxValue,
                      selectedHeight: _selectedHeight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
