import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/domain/use_case/save_avatar_use_case.dart';
import 'package:bodymetrics/feature/home/domain/use_case/home_users_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';

import 'package:flutter/material.dart';

part 'avatar_picker_model.dart';

@RoutePage(name: 'AvatarPickerView')
@immutable
final class AvatarPicker extends StatefulWidget {
  const AvatarPicker({
    super.key,
    this.isChangeProfile = false,
  });

  final bool isChangeProfile;

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> with DialogUtil, SaveAppMixin, _AvatarPickerModel {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.register_select_profile_picture,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            grid(),
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
            onTap: () => _tappedAvatar(index),
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
}
