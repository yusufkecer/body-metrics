part of '../home.dart';

@immutable
final class _MenuView extends StatelessWidget {
  const _MenuView(this.name, this.surname, this.image);

  final String name;
  final String surname;
  final String image;

  Future<void> _handleDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DeleteAccountDialog(),
    );
    if (!(confirmed ?? false) || !context.mounted) return;

    final success =
        await context.read<AuthSessionCubit>().deleteAccount();

    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.account_delete_error.tr()),
          backgroundColor: ProductColor.instance.bmiMorbidlyObese,
        ),
      );
    }
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    final currentLang = Lang.fromLocale(context.locale);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ProductColor.instance.seedColor,
          shape: RoundedRectangleBorder(
            borderRadius: const ProductRadius.fifteen(),
            side: BorderSide(color: ProductColor.instance.cardBorder),
          ),
          title: Text(
            LocaleKeys.home_menu_change_language.tr(),
            style: dialogContext.textTheme.titleMedium?.copyWith(
              color: ProductColor.instance.white,
            ),
          ),
          content: Column(
            spacing: SpaceValues.s.value,
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioGroup<Lang>(
                groupValue: currentLang,
                onChanged: (selected) {
                  if (selected == null) return;
                  context.setLocale(selected.locale).then((_) {
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                  });
                },
                child: Column(
                  spacing: SpaceValues.s.value,
                  mainAxisSize: MainAxisSize.min,
                  children: Lang.values.map((lang) {
                    return RadioListTile<Lang>(
                      value: lang,
                      activeColor: ProductColor.instance.white,
                      tileColor: ProductColor.instance.white.withAlpha(20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: ProductRadius.ten(),
                      ),
                      title: Text(
                        lang.displayName,
                        style: dialogContext.textTheme.bodyLarge?.copyWith(
                          color: ProductColor.instance.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      secondary: Container(
                        width: 52,
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: ProductColor.instance.white.withAlpha(25),
                          borderRadius: const ProductRadius.ten(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: const ProductRadius.four(),
                              child: Image.asset(
                                lang.flag,
                                width: 18,
                                height: 18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              lang.code,
                              style: dialogContext.textTheme.labelLarge
                                  ?.copyWith(
                                    color: ProductColor.instance.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -3,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPadding.fifTeen(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ProductColor.instance.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: Column(
                  children: [
                    Container(
                      padding: ProductPadding.four(),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ProductColor.instance.chartGradientEnd,
                      ),
                      child: CircleAvatar(
                        backgroundImage: image.isNotEmpty
                            ? AssetImage(image)
                            : null,
                        radius: 50,
                      ),
                    ),
                    VerticalSpace.s(),
                    Text(
                      '$name $surname',
                      style: context.textTheme.titleMedium,
                    ),
                    VerticalSpace.s(),
                  ],
                ),
              ),
              Column(
                children: [
                  _MenuTileWrapper(
                    child: CustomListTile(
                      ProductIcon.weight.icon,
                      LocaleKeys.home_menu_calculate_bmi,
                      () async {
                        await context.router.push(const WeightView());
                      },
                    ),
                  ),
                  VerticalSpace.s(),
                  BlocConsumer<AuthSessionCubit, AuthSessionState>(
                    listener: (context, state) async {
                      if (state is AuthSessionDeleted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              LocaleKeys.account_delete_success.tr(),
                            ),
                            backgroundColor: ProductColor.instance.bmiNormal,
                          ),
                        );
                        await context.router.pushAndPopUntil(
                          const AvatarPickerView(),
                          predicate: (_) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      final isAuthenticated =
                          state is AuthSessionAuthenticated ||
                              state is AuthSessionDeleting;
                      final isDeleting = state is AuthSessionDeleting;

                      if (isAuthenticated) {
                        return _MenuTileWrapper(
                          child: CustomListTile(
                            Icons.logout,
                            LocaleKeys.home_menu_logout,
                            isDeleting
                                ? null
                                : () async {
                                    await context
                                        .read<AuthSessionCubit>()
                                        .logout();
                                    if (context.mounted) {
                                      await context.router.pushAndPopUntil(
                                        const AvatarPickerView(),
                                        predicate: (_) => false,
                                      );
                                    }
                                  },
                          ),
                        );
                      }

                      return _MenuTileWrapper(
                        child: CustomListTile(
                          Icons.manage_accounts,
                          LocaleKeys.home_menu_user_operations,
                          () async {
                            final result = await context.router.push<bool>(
                              const UserOperationsView(),
                            );
                            if ((result ?? false) && context.mounted) {
                              await context
                                  .read<AuthSessionCubit>()
                                  .loadSession();
                            }
                          },
                        ),
                      );
                    },
                  ),
                  VerticalSpace.s(),
                  _MenuTileWrapper(
                    child: CustomListTile(
                      Icons.language,
                      LocaleKeys.home_menu_change_language,
                      () => _showLanguageDialog(context),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              BlocBuilder<AuthSessionCubit, AuthSessionState>(
                builder: (context, state) {
                  if (state is! AuthSessionAuthenticated &&
                      state is! AuthSessionDeleting) {
                    return const SizedBox.shrink();
                  }
                  final isDeleting = state is AuthSessionDeleting;
                  return GestureDetector(
                    onTap: isDeleting
                        ? null
                        : () => _handleDeleteAccount(context),
                    child: Padding(
                      padding: const ProductPadding.bottomM(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isDeleting) ...[
                            SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                color: ProductColor.instance.bmiObese
                                    .withAlpha(100),
                              ),
                            ),
                            HorizontalSpace.s(),
                          ],
                          Text(
                            LocaleKeys.account_delete_account.tr(),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: ProductColor.instance.bmiObese.withAlpha(
                                isDeleting ? 60 : 130,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _MenuTileWrapper extends StatelessWidget {
  const _MenuTileWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ProductColor.instance.transparent,
      borderRadius: const ProductRadius.ten(),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          color: ProductColor.instance.white.withAlpha(24),
          borderRadius: const ProductRadius.ten(),
          border: Border.all(color: ProductColor.instance.cardBorder),
        ),
        child: child,
      ),
    );
  }
}
