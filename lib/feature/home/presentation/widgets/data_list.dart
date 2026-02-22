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
  final ExpandedCard? expandedCard;
  final AnimationController animatedController;

  @override
  Widget build(BuildContext context) {
    final metrics = userMetrics?.userMetrics ?? [];
    if (metrics.isEmpty) return const SizedBox.shrink();

    return HomeCard(
      animationController: animatedController,
      buttonTitle: LocaleKeys.home_see_more,
      onPressed: onPressed,
      showButton: metrics.length >= 2,
      title: LocaleKeys.home_report,
      icon: ProductIcon.weight.icon,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: context.read<HomeCardCubit>().adjustLength(metrics.length),
          gridDelegate: const GridDelegate.dashBoard(),
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: ProductColor.instance.white),
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
                          title: LocaleKeys.home_weight,
                          subTitle: metrics[index].weight.toString(),
                        ),
                        CustomRichText(
                          icon: ProductIcon.userCheck.icon,
                          title: LocaleKeys.home_situation,
                          subTitle:
                              metrics[index].userMetric?.result.tr() ?? '',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          icon: ProductIcon.chart.icon,
                          title: LocaleKeys.home_bmi,
                          subTitle: metrics[index].bmi.toString(),
                        ),
                        CustomRichText(
                          icon: ProductIcon.calendar.icon,
                          title: LocaleKeys.home_date,
                          subTitle: metrics[index].displayDate,
                        ),
                      ],
                    ),
                    CustomRichText(
                      icon: metrics[index].resultIcon,
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

extension _ResultIconExtension on UserMetric {
  IconData get resultIcon {
    if (weightDiff == null) return ProductIcon.minus.icon;
    if (weightDiff! > 0) return ProductIcon.arrowUp.icon;
    if (weightDiff! < 0) return ProductIcon.trendingFlat.icon;
    return ProductIcon.minus.icon;
  }
}

extension _MetricDateExtension on UserMetric {
  String get displayDate {
    if (createdAt.isNullOrEmpty) return date ?? '';

    final parsed = DateTime.tryParse(createdAt!);
    if (parsed == null) return date ?? '';

    return DateFormat('dd-MM-yyyy').format(parsed);
  }
}
