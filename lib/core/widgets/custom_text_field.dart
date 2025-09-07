import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.hintText,
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.validator,
  });

  final String? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final IconData? prefixIcon;
  final String? hintText;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label?.tr() ?? '',
            style: context.textTheme.titleMedium,
          ),
          VerticalSpace.s(),
          Container(
            decoration: ProductDecoration.inputDecoration(),
            child: TextFormField(
              readOnly: readOnly,
              validator: validator,
              onTapOutside: (_) => context.unfocus(),
              onChanged: onChanged,
              controller: controller,
              onTap: onTap,
              decoration: InputDecoration(
                contentPadding: const ProductPadding.fifTeen(),
                border: InputBorder.none,
                errorStyle: context.textTheme.bodyMedium?.copyWith(color: ProductColor.instance.pink),
                prefixIcon: Icon(prefixIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
