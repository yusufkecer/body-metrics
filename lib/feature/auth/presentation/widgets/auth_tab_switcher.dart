part of '../user_operations.dart';

final class _AuthTabSwitcher extends StatelessWidget {
  const _AuthTabSwitcher();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceBright,
        borderRadius: const ProductRadius.fifteen(),
        boxShadow: [
          BoxShadow(
            color: ProductColor.instance.seedColor.withAlpha(55),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TabBar(
        dividerColor: ProductColor.instance.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: const ProductRadius.ten(),
          color: context.colorScheme.primary,
        ),
        indicatorPadding: const EdgeInsets.symmetric(vertical: 1),
        labelColor: context.colorScheme.surfaceBright,
        unselectedLabelColor: context.colorScheme.primary,
        labelStyle: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
        unselectedLabelStyle: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        splashBorderRadius: const ProductRadius.ten(),
        tabs: [
          SizedBox(
            height: 48,
            child: Center(child: Text(LocaleKeys.auth_login.tr())),
          ),
          SizedBox(
            height: 48,
            child: Center(child: Text(LocaleKeys.auth_register.tr())),
          ),
        ],
      ),
    );
  }
}
