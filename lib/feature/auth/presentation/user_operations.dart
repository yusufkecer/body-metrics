import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/register_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/auth_form_layout.dart';
part 'widgets/auth_input_field.dart';
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
      initialIndex: 1,
      child: GradientScaffold(
        appBar: const CustomAppBar(title: LocaleKeys.home_menu_user_operations),
        body: SafeArea(
          child: Padding(
            padding: const ProductPadding.fifTeen(),
            child: Column(
              children: [
                const _AuthTabSwitcher(),
                VerticalSpace.m(),
                const Expanded(
                  child: TabBarView(children: [_LoginTab(), _RegisterTab()]),
                ),
              ],
            ),
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
        return _AuthFormLayout(
          title: LocaleKeys.auth_login.tr(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AuthInputField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: LocaleKeys.auth_email.tr(),
                  icon: Icons.alternate_email_rounded,
                  validator: _validateEmail,
                ),
                VerticalSpace.m(),
                _AuthInputField(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: LocaleKeys.auth_password.tr(),
                  icon: Icons.lock_outline_rounded,
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
        return _AuthFormLayout(
          title: LocaleKeys.auth_register.tr(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AuthInputField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: LocaleKeys.auth_email.tr(),
                  icon: Icons.alternate_email_rounded,
                  validator: _validateEmail,
                ),
                VerticalSpace.m(),
                _AuthInputField(
                  controller: _passwordController,
                  obscureText: true,
                  labelText: LocaleKeys.auth_password.tr(),
                  icon: Icons.lock_outline_rounded,
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
