part of '../user_operations.dart';

final class _AuthInputField extends StatelessWidget {
  const _AuthInputField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: const ProductRadius.ten(),
      borderSide: BorderSide(
        color: context.colorScheme.primary.withAlpha(130),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            labelText,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.surfaceBright,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: TextStyle(
              color: context.colorScheme.primary.withAlpha(180),
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(icon, color: context.colorScheme.primary),
            filled: true,
            fillColor: context.colorScheme.surfaceBright,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            errorStyle: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surfaceBright,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(
                color: context.colorScheme.error.withAlpha(170),
              ),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
