part of '../home.dart';

@immutable
final class _DataList extends StatelessWidget {
  const _DataList({
    required this.userMetrics,
    required this.onPressed,
    required this.animatedController,
    this.expandedCard,
  });

  final UserMetrics? userMetrics;
  final void Function() onPressed;
  final _ExpandedCard? expandedCard;
  final AnimationController animatedController;

  @override
  Widget build(BuildContext context) {
    final metrics = userMetrics!.userMetrics;
    final statusIcon = metrics?.first.statusIcon;

    return HomeCard(
      animationController: animatedController,
      buttonTitle: LocaleKeys.home_see_more,
      onPressed: onPressed,
      title: LocaleKeys.home_report,
      icon: ProductIcon.weight.icon,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: expandedCard?.adjustLength(metrics!.length),
          gridDelegate: const GridDelegate.dashBoard(),
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ProductColor().white,
                ),
                borderRadius: const ProductRadius.ten(),
              ),
              child: Padding(
                padding: ProductPadding.ten(),
                child: SpaceColumn(
                  space: SpaceValues.xs.value,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          icon: ProductIcon.weight.icon,
                          title: '${LocaleKeys.home_weight}:',
                          subTitle: metrics![index].weight.toString(),
                        ),
                        CustomRichText(
                          icon: ProductIcon.userCheck.icon,
                          title: '${LocaleKeys.home_situation}:',
                          subTitle: metrics[index].userMetric?.result ?? '',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          icon: ProductIcon.chart.icon,
                          title: '${LocaleKeys.home_bmi}:',
                          subTitle: metrics[index].bmi.toString(),
                        ),
                        CustomRichText(
                          icon: ProductIcon.calendar.icon,
                          title: '${LocaleKeys.home_date}:',
                          subTitle: metrics[index].date ?? '',
                        ),
                      ],
                    ),
                    CustomRichText(
                      icon: IconData(
                        statusIcon!.codePoint,
                        fontFamily: statusIcon.fontFamily,
                      ),
                      title: LocaleKeys.home_weight_change,
                      subTitle: metrics[index].weightDiff.toString(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
