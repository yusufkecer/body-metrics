part of '../home.dart';

@immutable
final class _MenuView extends StatelessWidget {
  const _MenuView(this.name, this.surname, this.image);

  final String name;
  final String surname;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPadding.fifTeen(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: image.isNotEmpty
                          ? AssetImage(image)
                          : null,
                      radius: 50,
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
                  CustomListTile(
                    ProductIcon.weight.icon,
                    LocaleKeys.home_menu_calculate_bmi,
                    () async {
                      await context.router.push(const WeightView());
                    },
                  ),
                  VerticalSpace.s(),
                  BlocBuilder<AuthSessionCubit, AuthSessionState>(
                    builder: (context, state) {
                      final isAuthenticated = state is AuthSessionAuthenticated;
                      if (isAuthenticated) {
                        return CustomListTile(
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
                        );
                      }

                      return CustomListTile(
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
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
