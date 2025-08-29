import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/extensions/context_extension.dart';
import 'package:bodymetrics/core/init/language/locale_keys.g.dart';
import 'package:bodymetrics/core/widgets/buttons/dialog_text_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LottieConfirmDialog extends StatelessWidget {
  const LottieConfirmDialog({
    required this.assetValue,
    required this.title,
    super.key,
  });

  final String assetValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Lottie.asset(
        assetValue,
        width: context.width,
      ),
      content: Text(
        title.tr(),
        style: context.textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        DialogTextButton(
          title: LocaleKeys.dialog_cancel,
          onPressed: () => context.router.maybePop(false),
        ),
        DialogTextButton(
          onPressed: () => context.router.maybePop(true),
          title: LocaleKeys.dialog_yes,
        ),
      ],
    );
  }
}
