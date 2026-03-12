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
                color: ProductColor.instance.whiteAlpha20,
                borderRadius: const ProductRadius.twentyEight(),
                border: Border.all(color: ProductColor.instance.whiteAlpha40),
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
    this.readOnly = false,
    this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 2, bottom: 8),
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
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style:
              context.textTheme.bodyMedium?.copyWith(
                color: ProductColor.instance.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ) ??
              TextStyle(
                color: ProductColor.instance.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
          decoration: InputDecoration(
            hintText: widget.labelText,
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 12),
              child: Icon(widget.icon, size: 20),
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                    icon: Icon(
                      _isObscured
                          ? ProductIcon.eyeOpen.icon
                          : ProductIcon.eyeClosed.icon,
                      size: 18,
                    ),
                    padding: const EdgeInsetsDirectional.only(end: 14),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
