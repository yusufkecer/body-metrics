import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

final class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _controller = TextEditingController();
  bool _canDelete = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final expected = LocaleKeys.account_delete_type_to_confirm.tr();
    final matches = value.trim().toLowerCase() == expected.toLowerCase();
    if (matches != _canDelete) {
      setState(() => _canDelete = matches);
    }
  }

  @override
  Widget build(BuildContext context) {
    final phrase = LocaleKeys.account_delete_type_to_confirm.tr();
    return AlertDialog(
      backgroundColor: ProductColor.instance.seedColor,
      shape: RoundedRectangleBorder(
        borderRadius: const ProductRadius.fifteen(),
        side: BorderSide(color: ProductColor.instance.cardBorder),
      ),
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: ProductColor.instance.bmiObese,
            size: 22,
          ),
          HorizontalSpace.s(),
          Expanded(
            child: Text(
              LocaleKeys.account_delete_confirm_title.tr(),
              style: context.textTheme.titleMedium?.copyWith(
                color: ProductColor.instance.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SpaceValues.s.value,
        children: [
          Text(
            LocaleKeys.account_delete_confirm_message.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: ProductColor.instance.white.withAlpha(210),
              height: 1.5,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const ProductPadding.horizontal16Vertical18(),
            decoration: BoxDecoration(
              color: ProductColor.instance.bmiMorbidlyObese.withAlpha(40),
              borderRadius: const ProductRadius.ten(),
              border: Border.all(
                color: ProductColor.instance.bmiObese.withAlpha(100),
              ),
            ),
            child: Text(
              phrase,
              style: context.textTheme.bodyMedium?.copyWith(
                color: ProductColor.instance.bmiObese,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          TextField(
            controller: _controller,
            onChanged: _onChanged,
            style: context.textTheme.bodyMedium?.copyWith(
              color: ProductColor.instance.white,
            ),
            decoration: InputDecoration(
              hintText: LocaleKeys.account_delete_type_hint.tr(),
              hintStyle: context.textTheme.bodySmall?.copyWith(
                color: ProductColor.instance.whiteAlpha70,
              ),
              contentPadding: ProductPadding.horizontalTen(),
              enabledBorder: OutlineInputBorder(
                borderRadius: const ProductRadius.ten(),
                borderSide: BorderSide(
                  color: ProductColor.instance.whiteAlpha40,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const ProductRadius.ten(),
                borderSide: BorderSide(
                  color: ProductColor.instance.bmiObese,
                ),
              ),
            ),
          ),
        ],
      ),
      actionsPadding: const ProductPadding.backButton(),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => context.router.maybePop(false),
                style: TextButton.styleFrom(
                  padding: ProductPadding.verticalTwelve(),
                  shape: RoundedRectangleBorder(
                    borderRadius: const ProductRadius.ten(),
                    side: BorderSide(
                      color: ProductColor.instance.whiteAlpha40,
                    ),
                  ),
                ),
                child: Text(
                  LocaleKeys.dialog_cancel.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: ProductColor.instance.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            HorizontalSpace.s(),
            Expanded(
              child: TextButton(
                onPressed: _canDelete
                    ? () => context.router.maybePop(true)
                    : null,
                style: TextButton.styleFrom(
                  padding: ProductPadding.verticalTwelve(),
                  backgroundColor: _canDelete
                      ? ProductColor.instance.bmiMorbidlyObese
                      : ProductColor.instance.bmiMorbidlyObese.withAlpha(60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: ProductRadius.ten(),
                  ),
                ),
                child: Text(
                  LocaleKeys.account_delete_account.tr(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: _canDelete
                        ? ProductColor.instance.white
                        : ProductColor.instance.white.withAlpha(100),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
