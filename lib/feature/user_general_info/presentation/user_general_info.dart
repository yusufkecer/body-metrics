import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/cubit/user_general_info_state.dart';
import 'package:bodymetrics/feature/user_general_info/domain/repository/user_general_repository.dart';
import 'package:bodymetrics/feature/user_general_info/domain/use_case/user_general_use_case.dart';

import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_general_info_model.dart';

@RoutePage(name: 'UserInfoFormView')
@immutable
final class UserGeneralInfo extends StatefulWidget {
  final String avatar;
  const UserGeneralInfo({
    required this.avatar,
    super.key,
  });

  @override
  State<UserGeneralInfo> createState() => _UserGeneralInfoState();
}

class _UserGeneralInfoState extends State<UserGeneralInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Locator.sl<UserInfoFormCubit>(),
      child: GradientScaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.register_complete.tr(),
        ),
        body: _UserInfoFormBody(avatar: widget.avatar),
      ),
    );
  }
}

class _UserInfoFormBody extends StatefulWidget {
  final String avatar;
  const _UserInfoFormBody({
    required this.avatar,
  });

  @override
  State<_UserInfoFormBody> createState() => _UserInfoFormBodyState();
}

class _UserInfoFormBodyState extends State<_UserInfoFormBody> with DialogUtil, UserGeneralInfoModel {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              widget.avatar,
              width: context.width * 0.4,
            ),
          ),
          Form(
            onChanged: _formListener,
            canPop: context.watch<UserInfoFormCubit>().state.isFormEmpty,
            onPopInvoked: (isPop) async => _didPop(isFormEmpty: isPop),
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
          ),
          CustomFilled(
            text: LocaleKeys.save.tr(),
            onPressed: _onPressed,
          ),
        ],
      ),
    );
  }
}