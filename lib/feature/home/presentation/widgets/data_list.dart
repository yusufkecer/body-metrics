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
      buttonTitle: LocaleKeys.home_see_more.tr(),
      onPressed: onPressed,
      title: LocaleKeys.home_report.tr(),
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
                borderRadius: BorderRadius.circular(10),
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
                          title: '${LocaleKeys.home_weight.tr()}:',
                          subTitle: metrics![index].weight.toString(),
                        ),
                        CustomRichText(
                          icon: ProductIcon.userCheck.icon,
                          title: '${LocaleKeys.home_situation.tr()}:',
                          subTitle: metrics[index].userMetric?.result ?? '',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          icon: ProductIcon.chart.icon,
                          title: '${LocaleKeys.home_bmi.tr()}:',
                          subTitle: metrics[index].bmi.toString(),
                        ),
                        CustomRichText(
                          icon: ProductIcon.calendar.icon,
                          title: '${LocaleKeys.home_date.tr()}:',
                          subTitle: metrics[index].date ?? '',
                        ),
                      ],
                    ),
                    CustomRichText(
                      icon: IconData(
                        statusIcon!.codePoint,
                        fontFamily: statusIcon.fontFamily,
                      ),
                      title: LocaleKeys.home_weight_change.tr(),
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
