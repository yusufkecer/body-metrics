part of '../home.dart';

@immutable
final class _MenuView extends StatelessWidget {
  const _MenuView(this.name, this.surname, this.image);

  final String name;
  final String surname;
  final String image;

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final isCurrentlyTr = currentLocale == Lang.tr.locale;
    final nextLang = isCurrentlyTr ? Lang.en : Lang.tr;
    final nextFlag = nextLang.flag;

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
                        gradient: LinearGradient(
                          colors: [
                            ProductColor.instance.chartGradientStart,
                            ProductColor.instance.chartGradientEnd,
                          ],
                        ),
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
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: const ProductRadius.twelve(),
                  onTap: () => context.setLocale(nextLang.locale),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SpaceValues.s.value,
                      vertical: SpaceValues.xs.value,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(nextFlag, width: 32, height: 32),
                        HorizontalSpace.xs(),
                        Text(
                          nextLang == Lang.tr ? 'TR' : 'EN',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
