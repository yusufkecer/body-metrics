import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/extensions/regex_extension.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/presentation/cubit/user_info_form_cubit.dart';

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

class _UserInfoFormBodyState extends State<_UserInfoFormBody>
    with DialogUtil, SaveAppMixin, _UserGeneralInfoModel {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const ProductPadding.authForm(),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.router.maybePop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ProductColor.instance.whiteAlpha20,
                      borderRadius: const ProductRadius.twelve(),
                      border: Border.all(color: ProductColor.instance.whiteAlpha40),
                    ),
                    child: Icon(
                      ProductIcon.backArrow.icon,
                      color: ProductColor.instance.white,
                      size: 16,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  AppUtil.appName,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: ProductColor.instance.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                HorizontalSpace.s(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ProductColor.instance.whiteAlpha20,
                    border: Border.all(color: ProductColor.instance.whiteAlpha50),
                  ),
                  child: Icon(
                    ProductIcon.heartMonitor.icon,
                    color: ProductColor.instance.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          VerticalSpace.m(),
          Center(
            child: ClipOval(
              child: Image.asset(
                widget.avatar,
                width: context.width * 0.35,
              ),
            ),
          ),
          VerticalSpace.m(),
          Expanded(
            child: Padding(
              padding: ProductPadding.horizontalTwentyFour(),
              child: BlocListener<UserInfoFormCubit, UserInfoFormCubitState>(
                listener: (context, state) async {
                  if (state is UserInfoFormCubitError) {
                    showLottieError(state.error ?? LocaleKeys.dialog_general_error);
                  } else if (state is UserInfoFormCubitSuccess) {
                    final pageResult = await saveApp(Pages.genderPage);
                    if (pageResult != true) {
                      showLottieError(LocaleKeys.dialog_page_not_saved);
                      return;
                    }
                    await _pushToGender();
                  }
                },
                child: AuthFormLayout(
                  title: LocaleKeys.register_complete.tr(),
                  child: Form(
                    key: _formKey,
                    onChanged: _formListener,
                    canPop: context.watch<UserInfoFormCubit>().state.isFormEmpty,
                    onPopInvokedWithResult: (isPop, result) async {
                      return _didPop(isFormEmpty: isPop);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthInputField(
                          controller: _nameController,
                          labelText: LocaleKeys.register_name.tr(),
                          icon: ProductIcon.user.icon,
                          validator: (value) {
                            return _formValidator(
                              value,
                              LocaleKeys.register_name_required,
                            );
                          },
                        ),
                        VerticalSpace.m(),
                        AuthInputField(
                          controller: _surnameController,
                          labelText: LocaleKeys.register_surname.tr(),
                          icon: ProductIcon.users.icon,
                          validator: (value) {
                            return _formValidator(
                              value,
                              LocaleKeys.register_surname_required,
                            );
                          },
                        ),
                        VerticalSpace.m(),
                        AuthInputField(
                          controller: _birthOfDateController,
                          labelText: LocaleKeys.register_birth_of_date.tr(),
                          icon: ProductIcon.birthDay.icon,
                          readOnly: true,
                          onTap: _openDatePicker,
                          validator: (value) {
                            return _birthDateValidator(
                              _birthOfDateController.text,
                              LocaleKeys.register_birth_of_date_required,
                            );
                          },
                        ),
                        VerticalSpace.l(),
                        CustomFilled(
                          text: LocaleKeys.save,
                          onPressed: _saveUserInfo,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
