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

    final isExpanded = expandedCard == ExpandedCard.list;
    final itemCount = isExpanded ? metrics.length : metrics.length.clamp(0, 2);

    return HomeCard(
      animationController: animatedController,
      buttonTitle: isExpanded
          ? LocaleKeys.home_see_less
          : LocaleKeys.home_see_more,
      onPressed: onPressed,
      showButton: metrics.length >= 2,
      title: LocaleKeys.home_report,
      icon: ProductIcon.weight.icon,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          gridDelegate: const GridDelegate.dashBoard(),
          itemBuilder: (context, index) {
            final metric = metrics[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ProductColor.instance.seedColor.withAlpha(185),
                    ProductColor.instance.lightPurple.withAlpha(165),
                  ],
                ),
                borderRadius: const ProductRadius.fourteen(),
                border: Border.all(color: ProductColor.instance.cardBorder),
                boxShadow: [
                  BoxShadow(
                    color: ProductColor.instance.chartGradientEnd.withAlpha(45),
                    blurRadius: 14,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: ProductPadding.twelve(),
                child: SpaceColumn(
                  space: SpaceValues.xs.value,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          icon: ProductIcon.weight.icon,
                          title: LocaleKeys.home_weight,
                          subTitle: metric.weight?.toStringAsFixed(1) ?? '-',
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SpaceValues.s.value,
                            vertical: SpaceValues.xs.value,
                          ),
                          decoration: BoxDecoration(
                            color: metric.bmiBadgeColor.withAlpha(220),
                            borderRadius: const ProductRadius.ten(),
                          ),
                          child: Text(
                            metric.userMetric?.result.tr() ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: ProductColor.instance.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          icon: ProductIcon.chart.icon,
                          title: LocaleKeys.home_bmi,
                          subTitle: metric.bmi?.toStringAsFixed(2) ?? '-',
                        ),
                        CustomRichText(
                          icon: ProductIcon.calendar.icon,
                          title: LocaleKeys.home_date,
                          subTitle: metric.displayDate,
                        ),
                      ],
                    ),
                    if (index != 0) ...[
                      VerticalSpace.s(),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: SpaceValues.s.value,
                          vertical: SpaceValues.xs.value,
                        ),
                        decoration: BoxDecoration(
                          color: ProductColor.instance.white.withAlpha(20),
                          borderRadius: const ProductRadius.ten(),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              metric.resultIcon,
                              size: 14,
                              color: metric.weightDiffColor,
                            ),
                            HorizontalSpace.s(),
                            Text(
                              '${LocaleKeys.home_weight_change.tr()}: '
                              '${metric.weightDiffLabel}',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: metric.weightDiffColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
    if (weightDiff! < 0) return Icons.arrow_downward_rounded;
    return ProductIcon.minus.icon;
  }

  Color get bmiBadgeColor {
    switch (userMetric) {
      case BodyMetricResult.underweight:
        return ProductColor.instance.bmiUnderweight;
      case BodyMetricResult.normal:
        return ProductColor.instance.bmiNormal;
      case BodyMetricResult.overweight:
        return ProductColor.instance.bmiOverweight;
      case BodyMetricResult.obese:
        return ProductColor.instance.bmiObese;
      case BodyMetricResult.morbidlyObese:
        return ProductColor.instance.bmiMorbidlyObese;
      case BodyMetricResult.unknown:
      case null:
        return ProductColor.instance.whiteEightTenths;
    }
  }

  Color get weightDiffColor {
    if (weightDiff == null || weightDiff == 0) {
      return ProductColor.instance.whiteEightTenths;
    }
    if (weightDiff! > 0) return ProductColor.instance.bmiObese;
    return ProductColor.instance.bmiNormal;
  }

  String get weightDiffLabel {
    if (weightDiff == null || weightDiff == 0) return '-';
    final prefix = weightDiff! > 0 ? '+' : '';
    return '$prefix${weightDiff!.toStringAsFixed(1)}';
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
