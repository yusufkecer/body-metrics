part of '../avatar_picker.dart';

@immutable
final class UtilButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const UtilButton({required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .41,
      height: context.width * .41,
      child: ClipOval(
        child: Material(
          color: ProductColor().seedColor,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                icon,
                size: 30,
                color: ProductColor().white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
