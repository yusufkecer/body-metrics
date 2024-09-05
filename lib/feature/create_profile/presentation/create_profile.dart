import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/create_profile/cubit/profile_cubit.dart';
import 'package:bodymetrics/feature/create_profile/domain/entity/create_profile_entity.dart';
import 'package:bodymetrics/feature/create_profile/domain/repository/create_profile_repository.dart';
import 'package:bodymetrics/feature/create_profile/domain/use_case/create_profile_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_profile_model.dart';

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

class _UserInfoFormState extends State<UserInfoForm> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Locator.sl<UserInfoFormCubit>(instanceName: Locator.sl<CreateProfileEntity>().toString()),
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
    super.key,
  });

  @override
  State<_UserInfoFormBody> createState() => _UserInfoFormBodyState();
}

class _UserInfoFormBodyState extends State<_UserInfoFormBody> with DialogUtil, UserInfoFormModel {
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
            canPop: context.read<UserInfoFormCubit>().state.createProfileEntity.isFormEmpty,
            onPopInvoked: (isPop) async => _didPop(
                didPop: isPop, isFormEmpty: context.read<UserInfoFormCubit>().state.createProfileEntity.isFormEmpty),
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
