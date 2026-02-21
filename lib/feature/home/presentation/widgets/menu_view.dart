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
                  CustomListTile(
                    ProductIcon.user.icon,
                    LocaleKeys.home_menu_change_profile,
                    () async {
                      await context.router.push(
                        AvatarPickerView(isChangeProfile: true),
                      );
                    },
                  ),
                  VerticalSpace.s(),
                  CustomListTile(
                    ProductIcon.plus.icon,
                    LocaleKeys.home_menu_add_profile,
                    () async {
                      await context.router.push(AvatarPickerView());
                    },
                  ),
                  VerticalSpace.s(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
