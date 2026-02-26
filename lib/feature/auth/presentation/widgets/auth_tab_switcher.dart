part of '../user_operations.dart';

final class _AuthTabSwitcher extends StatelessWidget {
  const _AuthTabSwitcher();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const ProductRadius.fifty(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 52,
          padding: const ProductPadding.all4(),
          decoration: BoxDecoration(
            color: ProductColor.instance.blackAlpha65,
            borderRadius: const ProductRadius.fifty(),
            border: Border.all(
              color: ProductColor.instance.whiteAlpha28,
            ),
          ),
          child: TabBar(
            dividerColor: ProductColor.instance.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: const ProductRadius.fifty(),
              color: ProductColor.instance.whiteAlpha235,
              boxShadow: [
                BoxShadow(
                  color: ProductColor.instance.whiteAlpha55,
                  blurRadius: 14,
                ),
              ],
            ),
            indicatorPadding: const ProductPadding.vertical2(),
            labelColor: ProductColor.instance.deepPurple,
            unselectedLabelColor: ProductColor.instance.white,
            labelStyle: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.1,
            ),
            unselectedLabelStyle: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.1,
            ),
            splashBorderRadius: const ProductRadius.fifty(),
            tabs: [
              SizedBox(
                height: 42,
                child: Center(child: Text(LocaleKeys.auth_login.tr())),
              ),
              SizedBox(
                height: 42,
                child: Center(child: Text(LocaleKeys.auth_register.tr())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
