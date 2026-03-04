part of '../gender.dart';

@immutable
final class _GenderAsset extends StatelessWidget {
  const _GenderAsset({
    required this.asset,
    required this.gender,
    required this.onChanged,
    this.value,
    this.color,
    this.icon,
  });

  final ValueChanged<bool?> onChanged;
  final String asset;
  final String gender;
  final Color? color;
  final IconData? icon;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    final isSelected = value ?? false;
    final size = isSelected ? 190.0 : 170.0;

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: AnimatedContainer(
        duration: const ProductDuration.s2(),
        curve: Curves.easeInOut,
        padding: ProductPadding.ten(),
        decoration: BoxDecoration(
          color: ProductColor.instance.whiteAlpha20,
          borderRadius: const ProductRadius.twenty(),
          border: Border.all(
            color: isSelected
                ? ProductColor.instance.white
                : ProductColor.instance.whiteAlpha40,
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: AnimatedImage(
                  size: size,
                  child: RepaintBoundary(
                    child: Lottie.asset(
                      asset,
                      repeat: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (color ?? ProductColor.instance.white).withAlpha(25),
                  ),
                  child: Icon(
                    icon,
                    color: color ?? ProductColor.instance.white,
                    size: 18,
                  ),
                ),
                HorizontalSpace.s(),
                Text(
                  gender.tr(),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: ProductColor.instance.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                HorizontalSpace.s(),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? ProductColor.instance.white
                          : ProductColor.instance.whiteAlpha70,
                    ),
                    color: isSelected
                        ? ProductColor.instance.white
                        : ProductColor.instance.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 15,
                          color: ProductColor.instance.deepPurple,
                        )
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
