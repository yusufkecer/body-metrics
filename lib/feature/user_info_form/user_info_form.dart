import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

part 'user_info_form_model.dart';

@RoutePage(name: 'UserInfoFormView')
class UserInfoForm extends StatefulWidget {
  final String avatar;
  const UserInfoForm({
    required this.avatar,
    super.key,
  });

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> with DialogUtil, UserInfoFormModel {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: CustomAppBar(
        title: LocaleKeys.register_complete.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                widget.avatar,
                width: 150,
              ),
            ),
            CustomTextField(
              label: LocaleKeys.register_fullname.tr(),
              prefixIcon: ProductIcon.user.icon,
              controller: fullNameController,
            ),
            CustomElevated(
              text: LocaleKeys.save.tr(),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
