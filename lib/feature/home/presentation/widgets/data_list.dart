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

    return HomeCard(
      animationController: animatedController,
      size: expandedCard?.customSize(context),
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
                    CustomRichText(
                      title: LocaleKeys.home_weight.tr(),
                      subTitle: metrics![index].weight.toString(),
                    ),
                    CustomRichText(
                      title: LocaleKeys.home_bmi.tr(),
                      subTitle: metrics[index].bmi.toString(),
                    ),
                    CustomRichText(
                      title: LocaleKeys.home_situation.tr(),
                      subTitle: metrics[index].userMetric?.result ?? '',
                    ),
                    CustomRichText(
                      title: LocaleKeys.home_date.tr(),
                      subTitle: metrics[index].date ?? '',
                    ),
                    CustomRichText(
                      title: LocaleKeys.home_change.tr(),
                      subTitle: 'Sub Title',
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
