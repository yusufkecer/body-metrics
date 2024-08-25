part of '../weight_picker.dart';

final class _WeightIndicator extends StatelessWidget {
  final TextEditingController weightTextController;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool) fieldFocus;
  final void Function(String) textFieldChange;
  const _WeightIndicator({
    required this.weightTextController,
    required this.fieldFocus,
    required this.textFieldChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: ProductColor().white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Focus(
            onFocusChange: fieldFocus,
            child: TextField(
              controller: weightTextController,
              keyboardType: TextInputType.number,
              onTapOutside: (_) => context.unfocus,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: textFieldChange,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              style: context.textTheme.displaySmall!.copyWith(
                color: ProductColor().seedColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            LocaleKeys.weight_kg.tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge!.copyWith(
              color: ProductColor().seedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
