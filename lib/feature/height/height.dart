import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

part 'height_model.dart';
part 'widgets/ruler.dart';
part 'widgets/selected_height.dart';

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
      appBar: CustomAppBar(
        title: LocaleKeys.height_select_height.tr(),
        action: ColorfulText(
          colors: ProductColor().animatedColorList,
          speed: Durations.long3,
          text: LocaleKeys.cont.tr(),
          onTap: () {
            context.pushRoute(const ProfileImagePickerView());
          },
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Lottie.asset(
            _lottie!.lottie,
            height: _selectedHeight,
          ),
          Ruler(
            pageController: _pageController,
            maxValue: _maxValue,
            minValue: _minValue,
            selectedHeight: _currentCentimeter - 1,
          ),
        ],
      ),
    );
  }
}
