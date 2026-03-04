import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:bodymetrics/feature/auth/presentation/validation/auth_validation.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'ForgotPasswordView')
final class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => Locator.sl<ForgotPasswordCubit>(),
      child: const _ForgotPasswordBody(),
    );
  }
}

final class _ForgotPasswordBody extends StatefulWidget {
  const _ForgotPasswordBody();

  @override
  State<_ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

final class _ForgotPasswordBodyState extends State<_ForgotPasswordBody> {
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  bool _codeSent = false;
  String _email = '';

  @override
  void dispose() {
    _emailController.dispose();
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordCodeSent) {
          setState(() {
            _codeSent = true;
            _email = _emailController.text.trim();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.auth_forgot_password_code_sent.tr()),
            ),
          );
          return;
        }

        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.auth_forgot_password_success.tr()),
            ),
          );
          context.router.maybePop();
          return;
        }

        if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;

        return GradientScaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const ProductPadding.backButton(),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
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
                  ),
                ),
                VerticalSpace.xl(),
                Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProductColor.instance.whiteAlpha20,
                      border: Border.all(
                        color: ProductColor.instance.whiteAlpha40,
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      ProductIcon.lockReset.icon,
                      color: ProductColor.instance.white,
                      size: 32,
                    ),
                  ),
                ),
                VerticalSpace.ss(),
                Center(
                  child: Text(
                    LocaleKeys.auth_forgot_password_title.tr(),
                    style: context.textTheme.titleLarge?.copyWith(
                      color: ProductColor.instance.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                VerticalSpace.ss(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: _codeSent ? 8 : 24,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _codeSent
                            ? ProductColor.instance.whiteAlpha70
                            : ProductColor.instance.white,
                        borderRadius: const ProductRadius.four(),
                      ),
                    ),
                    HorizontalSpace.xs(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: _codeSent ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _codeSent
                            ? ProductColor.instance.white
                            : ProductColor.instance.whiteAlpha70,
                        borderRadius: const ProductRadius.four(),
                      ),
                    ),
                  ],
                ),
                VerticalSpace.l(),
                Expanded(
                  child: Padding(
                    padding: ProductPadding.horizontalTwentyFour(),
                    child: _codeSent
                        ? _buildStep2(context, isLoading)
                        : _buildStep1(context, isLoading),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep1(BuildContext context, bool isLoading) {
    return AuthFormLayout(
      title: LocaleKeys.auth_forgot_password_title.tr(),
      child: Form(
        key: _step1FormKey,
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
            VerticalSpace.l(),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  color: context.colorScheme.surfaceBright,
                ),
              )
            else
              CustomFilled(
                text: LocaleKeys.auth_forgot_password_send_code,
                onPressed: () {
                  if (_step1FormKey.currentState?.validate() != true) return;
                  context.read<ForgotPasswordCubit>().sendCode(
                    _emailController.text.trim(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2(BuildContext context, bool isLoading) {
    return AuthFormLayout(
      title: LocaleKeys.auth_forgot_password_title.tr(),
      child: Form(
        key: _step2FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthInputField(
              controller: _tokenController,
              keyboardType: TextInputType.number,
              labelText: LocaleKeys.auth_forgot_password_code.tr(),
              icon: ProductIcon.pin.icon,
              validator: _validateToken,
            ),
            VerticalSpace.m(),
            AuthInputField(
              controller: _passwordController,
              obscureText: true,
              labelText: LocaleKeys.auth_forgot_password_new_password.tr(),
              icon: ProductIcon.lockOutline.icon,
              validator: _validatePassword,
            ),
            VerticalSpace.m(),
            AuthInputField(
              controller: _confirmPasswordController,
              obscureText: true,
              labelText: LocaleKeys.auth_forgot_password_confirm_password.tr(),
              icon: ProductIcon.lockOutline.icon,
              validator: _validateConfirmPassword,
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
                text: LocaleKeys.auth_forgot_password_reset,
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_step2FormKey.currentState?.validate() != true) return;
                  context.read<ForgotPasswordCubit>().resetPassword(
                    email: _email,
                    token: _tokenController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (!AuthValidation.isValidEmail(value)) {
      return LocaleKeys.auth_invalid_email.tr();
    }
    return null;
  }

  String? _validateToken(String? value) {
    if (!AuthValidation.isValidForgotPasswordToken(value)) {
      return LocaleKeys.auth_forgot_password_code_hint.tr();
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (!AuthValidation.isValidPassword(value)) {
      return LocaleKeys.auth_password_min.tr();
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (!AuthValidation.isPasswordConfirmationValid(
      value,
      _passwordController.text,
    )) {
      return LocaleKeys.auth_forgot_password_passwords_not_match.tr();
    }
    return null;
  }
}
