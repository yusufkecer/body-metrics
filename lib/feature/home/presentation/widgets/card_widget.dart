part of '../home.dart';

class _CardWidget extends StatelessWidget {
  final void Function()? onPressed;
  final List<Widget> children;
  final String title;
  final String buttonTitle;
  final IconData icon;
  const _CardWidget({
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.children,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.38,
      child: Card(
        child: Padding(
          padding: ProductPadding.ten(),
          child: Padding(
            padding: ProductPadding.four().copyWith(top: 0, bottom: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: const CustomSize.dashboardTitle().width,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          icon,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: const CustomSize.dashboardTitle().width,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: onPressed,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            buttonTitle,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: ProductColor().white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...children,
                VerticalSpace.s(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}