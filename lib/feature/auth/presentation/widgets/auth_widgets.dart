import 'dart:ui';

import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

final class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const ProductPadding.bottomM(),
        child: ClipRRect(
          borderRadius: const ProductRadius.twentyEight(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              width: double.infinity,
              padding: const ProductPadding.glassCard(),
              decoration: BoxDecoration(
                color: ProductColor.instance.whiteAlpha18,
                borderRadius: const ProductRadius.twentyEight(),
                border: Border.all(color: ProductColor.instance.whiteAlpha45),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: ProductColor.instance.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  VerticalSpace.xs(),
                  Container(
                    height: 2,
                    width: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ProductColor.instance.white,
                          ProductColor.instance.whiteAlpha0,
                        ],
                      ),
                      borderRadius: const ProductRadius.one(),
                    ),
                  ),
                  VerticalSpace.xl(),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class AuthInputField extends StatefulWidget {
  const AuthInputField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: const ProductRadius.sixteen(),
      borderSide: BorderSide(color: ProductColor.instance.whiteAlpha55),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const ProductPadding.left2Bottom8(),
          child: Text(
            widget.labelText,
            style: context.textTheme.labelSmall?.copyWith(
              color: ProductColor.instance.whiteAlpha200,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          style: context.textTheme.bodyMedium?.copyWith(
            color: ProductColor.instance.white,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: ProductColor.instance.whiteAlpha80,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            prefixIcon: Padding(
              padding: const ProductPadding.left16Right12(),
              child: Icon(
                widget.icon,
                color: ProductColor.instance.whiteAlpha160,
                size: 20,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 52),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                    icon: Icon(
                      _isObscured
                          ? ProductIcon.eyeOpen.icon
                          : ProductIcon.eyeClosed.icon,
                      color: ProductColor.instance.whiteAlpha130,
                      size: 18,
                    ),
                    padding: const ProductPadding.right14(),
                  )
                : null,
            filled: true,
            fillColor: ProductColor.instance.blackAlpha50,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const ProductPadding.horizontal16Vertical18(),
            errorStyle: context.textTheme.labelSmall?.copyWith(
              color: ProductColor.instance.warning,
              fontWeight: FontWeight.w500,
              fontSize: 11,
              height: 1.4,
            ),
            enabledBorder: baseBorder,
            focusedBorder: baseBorder.copyWith(
              borderSide: BorderSide(
                color: ProductColor.instance.whiteAlpha160,
                width: 1.5,
              ),
            ),
            errorBorder: baseBorder.copyWith(
              borderSide: BorderSide(
                color: ProductColor.instance.warning,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: baseBorder.copyWith(
              borderSide: BorderSide(
                color: ProductColor.instance.warning,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
