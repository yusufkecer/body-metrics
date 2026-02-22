part of '../user_operations.dart';

final class _AuthFormLayout extends StatelessWidget {
  const _AuthFormLayout({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: context.height * 0.7),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            decoration: BoxDecoration(
              color: ProductColor.instance.seedColor.withAlpha(92),
              borderRadius: const ProductRadius.fifteen(),
              border: Border.all(
                color: ProductColor.instance.white.withAlpha(132),
              ),
              boxShadow: [
                BoxShadow(
                  color: ProductColor.instance.seedColor.withAlpha(45),
                  blurRadius: 18,
                  spreadRadius: 1,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colorScheme.surfaceBright,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                VerticalSpace.l(),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
