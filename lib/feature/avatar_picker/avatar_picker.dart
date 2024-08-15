import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/init/index.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

part 'avatar_picker_model.dart';

@RoutePage(name: 'AvatarPickerView')
class AvatarPicker extends StatefulWidget {
  const AvatarPicker({super.key});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> with AvatarPickerModel {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: CustomAppBar(
        title: LocaleKeys.register_select_profile_picture.tr(),
        action: TextButton(
          onPressed: () {
            context.pushRoute(const GenderView());
          },
          child: Text(
            LocaleKeys.register_skip.tr(),
            style: context.textTheme.titleMedium!.copyWith(
              color: ProductColor().white,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: avatarList.length,
        gridDelegate: const GridDelegate.profileImageGrid(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const ProductPadding.ten(),
            child: GestureDetector(
              onTap: () => onTapProfileImage(avatarList[index]),
              child: CircleAvatar(
                child: Image.asset(
                  avatarList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
