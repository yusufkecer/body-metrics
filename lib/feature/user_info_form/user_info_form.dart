import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/core/widgets/custom_elevated.dart';
import 'package:bmicalculator/core/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

part 'user_info_form_model.dart';

@RoutePage(name: 'UserInfoFormView')
class UserInfoForm extends StatefulWidget {
  final String image;
  const UserInfoForm({
    required this.image,
    super.key,
  });

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> with UserInfoFormModel {
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
                widget.image,
                width: 150,
              ),
            ),
            CustomTextField(
              label: LocaleKeys.register_fullname.tr(),
              prefixIcon: ProductIcon.user.icon,
              controller: TextEditingController(),
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
