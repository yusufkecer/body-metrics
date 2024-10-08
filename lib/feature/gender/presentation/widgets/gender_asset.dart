part of '../gender.dart';

@immutable
final class _GenderAsset extends StatelessWidget {
  const _GenderAsset({
    required this.asset,
    required this.gender,
    this.value,
    this.color,
    this.icon,
    this.onChanged,
  });

  final void Function({bool? value})? onChanged;
  final String asset;
  final String gender;
  final Color? color;
  final IconData? icon;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    var size = 200.0;
    size = (value ?? false) ? 300.0 : 250.0;
    return GestureDetector(
      onTap: () => onChanged!(value: !(value ?? false)),
      child: AnimatedImage(
        size: size,
        child: Column(
          children: [
            Wrap(
              children: [
                Text(
                  gender,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge?.copyWith(color: color),
                ),
                HorizontalSpace.xs(),
                Icon(icon, color: color),
              ],
            ),
            Stack(
              children: [
                RepaintBoundary(
                  child: Lottie.asset(
                    asset,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Checkbox(
                    value: value ?? false,
                    onChanged: (value) => onChanged!(value: value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
