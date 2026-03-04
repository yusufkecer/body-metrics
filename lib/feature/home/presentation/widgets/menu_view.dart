part of '../home.dart';

@immutable
final class _MenuView extends StatelessWidget {
  const _MenuView(this.name, this.surname, this.image);

  final String name;
  final String surname;
  final String image;

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
            children: Lang.values.map((lang) {
              return RadioListTile<Lang>(
                value: lang,
                groupValue: currentLang,
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
                        style: dialogContext.textTheme.labelLarge?.copyWith(
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
                onChanged: (selected) async {
                  if (selected == null) return;
                  await context.setLocale(selected.locale);
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                },
              );
            }).toList(),
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
                  BlocBuilder<AuthSessionCubit, AuthSessionState>(
                    builder: (context, state) {
                      final isAuthenticated = state is AuthSessionAuthenticated;
                      if (isAuthenticated) {
                        return _MenuTileWrapper(
                          child: CustomListTile(
                            Icons.logout,
                            LocaleKeys.home_menu_logout,
                            () async {
                              await context.read<AuthSessionCubit>().logout();
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
    return Container(
      padding: ProductPadding.horizontalEight(),
      decoration: BoxDecoration(
        color: ProductColor.instance.white.withAlpha(24),
        borderRadius: const ProductRadius.ten(),
        border: Border.all(color: ProductColor.instance.cardBorder),
      ),
      child: child,
    );
  }
}
