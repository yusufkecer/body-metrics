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
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
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
                          padding: ProductPadding.horizontalSVerticalXs(),
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
                        padding: ProductPadding.horizontalSVerticalXs(),
                        decoration: BoxDecoration(
                          color: ProductColor.instance.whiteAlpha20,
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
                    _BmiRangeIndicator(
                      bmi: metric.bmi,
                      result: metric.userMetric,
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

@immutable
final class _BmiRangeIndicator extends StatelessWidget {
  const _BmiRangeIndicator({required this.bmi, required this.result});

  final double? bmi;
  final BodyMetricResult? result;

  static const double _min = 10.0;
  static const double _max = 45.0;
  static const double _t1 = 18.5; // underweight → normal
  static const double _t2 = 25.0; // normal → overweight
  static const double _t3 = 30.0; // overweight → obese
  static const double _t4 = 40.0; // obese → morbidly obese

  @override
  Widget build(BuildContext context) {
    final v = (bmi ?? 0.0).clamp(_min, _max);
    final pc = ProductColor.instance;

    return Container(
      padding: ProductPadding.horizontalSVerticalXs(),
      decoration: BoxDecoration(
        color: pc.whiteAlpha20,
        borderRadius: const ProductRadius.ten(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.home_bmi_zone.tr(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: pc.whiteEightTenths,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _proximityText(v),
                style: context.textTheme.labelSmall?.copyWith(
                  color: _zoneColor(result, pc).withAlpha(230),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LayoutBuilder(
            builder: (ctx, box) {
              final w = box.maxWidth;
              final frac = (v - _min) / (_max - _min);
              final markerLeft = (frac * (w - 10)).clamp(0.0, w - 10.0);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: w,
                    height: 20,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 6,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SizedBox(
                              height: 8,
                              child: Row(
                                children: [
                                  _seg(w, _min, _t1, pc.bmiUnderweight),
                                  _seg(w, _t1, _t2, pc.bmiNormal),
                                  _seg(w, _t2, _t3, pc.bmiOverweight),
                                  _seg(w, _t3, _t4, pc.bmiObese),
                                  _seg(w, _t4, _max, pc.bmiMorbidlyObese),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: markerLeft,
                          child: Container(
                            width: 10,
                            height: 20,
                            decoration: BoxDecoration(
                              color: pc.white,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: _zoneColor(result, pc).withAlpha(200),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    width: w,
                    height: 12,
                    child: Stack(children: _thresholdLabels(context, w)),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _seg(double totalW, double from, double to, Color color) {
    return SizedBox(
      width: (to - from) / (_max - _min) * totalW,
      child: ColoredBox(color: color.withAlpha(210)),
    );
  }

  List<Widget> _thresholdLabels(BuildContext context, double w) {
    const ts = [_min, _t1, _t2, _t3, _t4, _max];
    const ls = ['10', '18.5', '25', '30', '40', '45+'];
    final style = context.textTheme.labelSmall?.copyWith(
      color: ProductColor.instance.whiteAlpha80,
      fontSize: 9,
    );
    return List.generate(ts.length, (i) {
      final frac = (ts[i] - _min) / (_max - _min);
      final approxLabelW = ls[i].length * 5.5;
      final left = (frac * w - approxLabelW / 2).clamp(0.0, w - approxLabelW);
      return Positioned(
        left: left,
        top: 0,
        child: Text(ls[i], style: style),
      );
    });
  }

  static Color _zoneColor(BodyMetricResult? r, ProductColor pc) {
    switch (r) {
      case BodyMetricResult.underweight:
        return pc.bmiUnderweight;
      case BodyMetricResult.normal:
        return pc.bmiNormal;
      case BodyMetricResult.overweight:
        return pc.bmiOverweight;
      case BodyMetricResult.obese:
        return pc.bmiObese;
      case BodyMetricResult.morbidlyObese:
        return pc.bmiMorbidlyObese;
      case BodyMetricResult.unknown:
      case null:
        return pc.whiteEightTenths;
    }
  }

  static String _proximityText(double v) {
    if (v < _t1) {
      return '→ ${BodyMetricResult.normal.result.tr()}: ${(_t1 - v).toStringAsFixed(1)}';
    } else if (v < _t2) {
      return '→ ${BodyMetricResult.overweight.result.tr()}: ${(_t2 - v).toStringAsFixed(1)}';
    } else if (v < _t3) {
      return '← ${BodyMetricResult.normal.result.tr()}: ${(v - _t2).toStringAsFixed(1)}';
    } else if (v < _t4) {
      return '← ${BodyMetricResult.overweight.result.tr()}: ${(v - _t3).toStringAsFixed(1)}';
    } else {
      return '← ${BodyMetricResult.obese.result.tr()}: ${(v - _t4).toStringAsFixed(1)}';
    }
  }
}

extension _ResultIconExtension on UserMetric {
  IconData get resultIcon {
    if (weightDiff == null) return ProductIcon.minus.icon;
    if (weightDiff! > 0) return ProductIcon.arrowUp.icon;
    if (weightDiff! < 0) return ProductIcon.arrowDown.icon;
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
