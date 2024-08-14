import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

part 'profile_image_picker_model.dart';

@RoutePage(name: 'ProfileImagePickerView')
class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> with ProfileImagePickerModel {
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
        itemCount: profileImages.length,
        gridDelegate: GridDelegate.profileImageGrid(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const ProductPadding.ten(),
            child: GestureDetector(
              onTap: () => onTapProfileImage(index),
              child: CircleAvatar(
                child: Image.asset(
                  profileImages[index],
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
