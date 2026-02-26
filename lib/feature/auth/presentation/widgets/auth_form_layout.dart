part of '../user_operations.dart';

final class _AuthFormLayout extends StatelessWidget {
  const _AuthFormLayout({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const ProductPadding.bottomM(),
        child: ClipRRect(
          borderRadius: const ProductRadius.twentyEight(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              width: double.infinity,
              padding: const ProductPadding.glassCard(),
              decoration: BoxDecoration(
                color: ProductColor.instance.whiteAlpha18,
                borderRadius: const ProductRadius.twentyEight(),
                border: Border.all(
                  color: ProductColor.instance.whiteAlpha45,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: ProductColor.instance.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  VerticalSpace.xs(),
                  Container(
                    height: 2,
                    width: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ProductColor.instance.white,
                          ProductColor.instance.whiteAlpha0,
                        ],
                      ),
                      borderRadius: const ProductRadius.one(),
                    ),
                  ),
                  VerticalSpace.xl(),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
