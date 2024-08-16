import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'avatar_picker_model.dart';
part 'widgets/util_button.dart';

@RoutePage(name: 'AvatarPickerView')
class AvatarPicker extends StatefulWidget {
  final bool canSkip;
  const AvatarPicker({
    super.key,
    this.canSkip = true,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> with AvatarPickerModel {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: CustomAppBar(
        title: LocaleKeys.register_select_profile_picture.tr(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            grid(),
            utilButtons(),
            VerticalSpace.m(),
          ],
        ),
      ),
    );
  }

  GridView grid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: avatarList.length,
      gridDelegate: const GridDelegate.profileImageGrid(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const ProductPadding.ten(),
          child: InkWell(
            onTap: () => addNewProfile(index),
            child: CircleAvatar(
              child: Image.asset(
                avatarList[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget utilButtons() {
    return widget.canSkip
        ? Column(
            children: [
              VerticalSpace.xs(),
              UtilButton(
                icon: FontAwesomeIcons.arrowRight,
                onPressed: onTapSkip,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
