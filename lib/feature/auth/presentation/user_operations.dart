import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/register_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/widgets/auth_widgets.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/auth_tab_switcher.dart';

@RoutePage(name: 'UserOperationsView')
final class UserOperations extends StatelessWidget {
  const UserOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => Locator.sl<LoginCubit>()),
        BlocProvider<RegisterCubit>(create: (_) => Locator.sl<RegisterCubit>()),
      ],
      child: const _UserOperationsBody(),
    );
  }
}

final class _UserOperationsBody extends StatelessWidget {
  const _UserOperationsBody();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GradientScaffold(
        body: SafeArea(
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
                          border: Border.all(
                            color: ProductColor.instance.whiteAlpha40,
                          ),
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
                      'BodyMetrics',
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
                        border: Border.all(
                          color: ProductColor.instance.whiteAlpha50,
                        ),
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
              VerticalSpace.l(),
              Padding(
                padding: ProductPadding.horizontalTwentyFour(),
                child: const _AuthTabSwitcher(),
              ),
              VerticalSpace.m(),
              Expanded(
                child: Padding(
                  padding: ProductPadding.horizontalTwentyFour(),
                  child: const TabBarView(
                    children: [_LoginTab(), _RegisterTab()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _LoginTab extends StatefulWidget {
  const _LoginTab();

  @override
  State<_LoginTab> createState() => _LoginTabState();
}

final class _LoginTabState extends State<_LoginTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.router.maybePop(true);
          return;
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return AuthFormLayout(
          title: LocaleKeys.auth_login.tr(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthInputField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: LocaleKeys.auth_email.tr(),
                  icon: ProductIcon.email.icon,
                  validator: _validateEmail,
                ),
                VerticalSpace.m(),
                AuthInputField(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: LocaleKeys.auth_password.tr(),
                  icon: ProductIcon.lockOutline.icon,
                  validator: _validatePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        context.router.push(const ForgotPasswordView()),
                    child: Text(
                      LocaleKeys.auth_forgot_password_link.tr(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.surfaceBright,
                      ),
                    ),
                  ),
                ),
                VerticalSpace.l(),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: context.colorScheme.surfaceBright,
                    ),
                  )
                else
                  CustomFilled(
                    text: LocaleKeys.auth_login,
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) return;
                      context.read<LoginCubit>().login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty || !ProductRegex.email.hasMatch(email)) {
      return LocaleKeys.auth_invalid_email.tr();
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value?.trim() ?? '';
    if (password.length < 6) {
      return LocaleKeys.auth_password_min.tr();
    }
    return null;
  }
}

final class _RegisterTab extends StatefulWidget {
  const _RegisterTab();

  @override
  State<_RegisterTab> createState() => _RegisterTabState();
}

final class _RegisterTabState extends State<_RegisterTab> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppUtil.syncPending = true;
          context.router.maybePop(true);
          return;
        }

        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        return AuthFormLayout(
          title: LocaleKeys.auth_register.tr(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthInputField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: LocaleKeys.auth_email.tr(),
                  icon: ProductIcon.email.icon,
                  validator: _validateEmail,
                ),
                VerticalSpace.m(),
                AuthInputField(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: LocaleKeys.auth_password.tr(),
                  icon: ProductIcon.lockOutline.icon,
                  validator: _validatePassword,
                ),
                VerticalSpace.l(),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: context.colorScheme.surfaceBright,
                    ),
                  )
                else
                  CustomFilled(
                    text: LocaleKeys.auth_register,
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) return;
                      context.read<RegisterCubit>().register(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty || !ProductRegex.email.hasMatch(email)) {
      return LocaleKeys.auth_invalid_email.tr();
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value?.trim() ?? '';
    if (password.length < 6) {
      return LocaleKeys.auth_password_min.tr();
    }
    return null;
  }
}
