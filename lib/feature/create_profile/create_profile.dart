import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'domain/entitiy/form_control.dart';
part 'create_profile_model.dart';

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
            ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (_, value, ___) {
                return Form(
                  key: _formKey,
                  onChanged: _formListener,
                  canPop: !value.isFormEmpty,
                  onPopInvoked: (didPop) async {
                    value.isFormEmpty.w;
                    if (!value.isFormEmpty) {
                      await context.router.maybePop();
                      return;
                    }

                    final result = await confirmDialog(LocaleKeys.dialog_progress_lost.tr());
                    if ((result.isNotNull && !result!) || !context.mounted) return;
                    _valueNotifier.value = _valueNotifier.value.copyWith(isFormEmpty: false);
                    await Future.delayed(Duration.zero, () => context.router.maybePop());
                  },
                  child: Column(
                    children: [
                      CustomTextField(
                        label: LocaleKeys.register_full_name.tr(),
                        prefixIcon: ProductIcon.user.icon,
                        controller: _fullNameController,
                      ),
                      CustomTextField(
                        label: LocaleKeys.register_birt_of_date.tr(),
                        readOnly: true,
                        onTap: _openDatePicker,
                        prefixIcon: ProductIcon.birthDay.icon,
                        controller: _birthofDateController,
                      ),
                    ],
                  ),
                );
              },
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
