import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/domain/use_case/save_avatar_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'avatar_picker_model.dart';
part 'widgets/util_button.dart';

@RoutePage(name: 'AvatarPickerView')
@immutable
final class AvatarPicker extends StatefulWidget {
  const AvatarPicker({
    super.key,
    this.canSkip = true,
  });

  final bool canSkip;

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> with DialogUtil, SavePageMixin, _AvatarPickerModel {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
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
          padding: ProductPadding.ten(),
          child: InkWell(
            onTap: () => _addNewProfile(index),
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
                onPressed: _onTapSkip,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
