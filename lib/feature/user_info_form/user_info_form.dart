import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

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
            Form(
              canPop: !isAnyProgress,
              onPopInvoked: (didPop) async {
                context.unfocus;
                if (!isAnyProgress) {
                  await context.maybePop(isAnyProgress);
                  return;
                }

                final value = await confirmDialog('EMİN MİSİNİZ?');
                if (value ?? false) {
                  if (!context.mounted) return;

                  await context.maybePop(isAnyProgress);
                }
              },
              child: Column(
                children: [
                  CustomTextField(
                    label: LocaleKeys.register_fullname.tr(),
                    prefixIcon: ProductIcon.user.icon,
                    controller: _fullNameController,
                  ),
                  CustomTextField(
                    label: 'Doğum Tarihi',
                    readOnly: true,
                    onTap: _openDatePicker,
                    prefixIcon: ProductIcon.birthDay.icon,
                    controller: _birthofDateController,
                  ),
                ],
              ),
            ),
            CustomElevated(
              text: LocaleKeys.save.tr(),
              onPressed: _onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
