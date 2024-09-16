part of '../home.dart';

class _MenuView extends StatelessWidget {
  const _MenuView();

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
                      backgroundImage: AssetImage(AssetValue.profile1.value.profile),
                      radius: 50,
                    ),
                    VerticalSpace.s(),
                    Text(
                      'John Doe',
                      style: context.textTheme.titleMedium,
                    ),
                    VerticalSpace.s(),
                  ],
                ),
              ),
              VerticalSpace.s(),
              TextIconButton(
                title: LocaleKeys.home_home.tr(),
                icon: Icons.home,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
