import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'create_profile_model.dart';
part '../domain/entity/form_control.dart';
part '../domain/repository/create_profile_repository.dart';
part '../domain/use_case/create_profile_use_case.dart';

@RoutePage(name: 'UserInfoFormView')
@immutable
final class UserInfoForm extends StatefulWidget {
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
    return GradientScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.register_complete.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                widget.avatar,
                width: context.width * 0.4,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (_, value, ___) {
                return Form(
                  onChanged: _formListener,
                  canPop: !value._isFormEmpty,
                  onPopInvoked: (isPop) async => _didPop(didPop: isPop, isFormEmpty: value._isFormEmpty),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: LocaleKeys.register_full_name.tr(),
                        prefixIcon: ProductIcon.user.icon,
                        controller: _fullNameController,
                      ),
                      CustomTextField(
                        label: LocaleKeys.register_birth_of_date.tr(),
                        readOnly: true,
                        onTap: _openDatePicker,
                        prefixIcon: ProductIcon.birthDay.icon,
                        controller: _birthOfDateController,
                      ),
                    ],
                  ),
                );
              },
            ),
            CustomFilled(
              text: LocaleKeys.save.tr(),
              onPressed: _onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
