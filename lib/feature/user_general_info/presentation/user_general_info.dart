import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/extensions/regex_extension.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/cubit/user_info_form_cubit.dart';

import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_general_info_model.dart';

@RoutePage(name: 'UserGeneralInfoView')
@immutable
final class UserGeneralInfo extends StatelessWidget {
  const UserGeneralInfo({
    required this.avatar,
    super.key,
  });

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.register_complete,
      ),
      body: BlocProvider(
        create: (_) => Locator.sl<UserInfoFormCubit>(),
        child: _UserInfoFormBody(avatar: avatar),
      ),
    );
  }
}

@immutable
final class _UserInfoFormBody extends StatefulWidget {
  const _UserInfoFormBody({
    required this.avatar,
  });

  final String avatar;

  @override
  State<_UserInfoFormBody> createState() => _UserInfoFormBodyState();
}

class _UserInfoFormBodyState extends State<_UserInfoFormBody> with DialogUtil, SaveAppMixin, _UserGeneralInfoModel {
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
            key: _formKey,
            onChanged: _formListener,
            canPop: context.watch<UserInfoFormCubit>().state.isFormEmpty,
            onPopInvokedWithResult: (isPop, result) async {
              return _didPop(isFormEmpty: isPop);
            },
            child: Column(
              children: [
                CustomTextField(
                  label: LocaleKeys.register_name,
                  prefixIcon: ProductIcon.user.icon,
                  controller: _nameController,
                  validator: (value) {
                    return _formValidator(value, LocaleKeys.register_name_required);
                  },
                ),
                CustomTextField(
                  label: LocaleKeys.register_surname,
                  prefixIcon: ProductIcon.users.icon,
                  controller: _surnameController,
                  validator: (value) {
                    return _formValidator(value, LocaleKeys.register_surname_required);
                  },
                ),
                CustomTextField(
                  label: LocaleKeys.register_birth_of_date,
                  readOnly: true,
                  onTap: _openDatePicker,
                  prefixIcon: ProductIcon.birthDay.icon,
                  controller: _birthOfDateController,
                  validator: (value) {
                    return _formValidator(value, LocaleKeys.register_birth_of_date_required);
                  },
                ),
              ],
            ),
          ),
          BlocListener<UserInfoFormCubit, UserInfoFormCubitState>(
            listener: (context, state) async {
              if (state is UserInfoFormCubitError) {
                showLottieError(state.error ?? LocaleKeys.dialog_general_error);
              } else if (state is UserInfoFormCubitSuccess) {
                final pageResult = await saveApp(Pages.genderPage);
                if (pageResult != true) {
                  showLottieError(LocaleKeys.dialog_page_not_saved);
                  return;
                }
                await pushToGender();
              }
            },
            child: CustomFilled(
              text: LocaleKeys.save,
              onPressed: _createProfile,
            ),
          ),
        ],
      ),
    );
  }
}
