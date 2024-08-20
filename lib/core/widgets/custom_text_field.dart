import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final IconData? prefixIcon;
  final String? hintText;
  final bool readOnly;

  const CustomTextField({
    this.hintText,
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '',
            style: context.textTheme.titleMedium,
          ),
          VerticalSpace.s(),
          Container(
            decoration: ProductDecoration.inputDecoration(),
            child: TextField(
              readOnly: readOnly,
              onTapOutside: (_) => context.unfocus,
              onChanged: onChanged,
              controller: controller,
              onTap: onTap,
              decoration: InputDecoration(
                contentPadding: const ProductPadding.fifTeen(),
                border: InputBorder.none,
                prefixIcon: Icon(prefixIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
