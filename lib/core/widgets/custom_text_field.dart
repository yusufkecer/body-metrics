import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final String? hintText;

  const CustomTextField({
    this.hintText,
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPadding.ten(),
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
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: onChanged,
              controller: controller,
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
