part of '../home.dart';

class _DataList extends StatefulWidget {
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
  State<_DataList> createState() => _DataListState();
}

class _DataListState extends State<_DataList>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_DataList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expandedCard != widget.expandedCard) {
      _staggerController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final metrics = (widget.userMetrics?.userMetrics ?? []).reversed.toList();
    if (metrics.isEmpty) return const SizedBox.shrink();

    final isExpanded = widget.expandedCard == ExpandedCard.list;
    final baseMetrics = metrics.take(2).toList();
    final extraMetrics = metrics.length > 2
        ? metrics.sublist(2)
        : const <UserMetric>[];

    return HomeCard(
      animationController: widget.animatedController,
      buttonTitle: isExpanded
          ? LocaleKeys.home_see_less
          : LocaleKeys.home_see_more,
      onPressed: metrics.length >= 3 ? widget.onPressed : () {},
      showButton: metrics.length >= 3,
      title: LocaleKeys.home_report,
      icon: ProductIcon.weight.icon,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: baseMetrics.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _StaggeredMetricCard(
              staggerController: _staggerController,
              index: index,
              child: _buildMetricCard(
                context,
                baseMetrics[index],
                index,
                isLast: index == metrics.length - 1,
              ),
            );
          },
        ),
        if (extraMetrics.isNotEmpty) ...[
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return ClipRect(
                child: SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                  axisAlignment: -1,
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0, 0.8, curve: Curves.easeOut),
                    ),
                    child: child,
                  ),
                ),
              );
            },
            child: isExpanded
                ? Column(
                    key: const ValueKey<String>('expanded_extra_metrics'),
                    children: List.generate(extraMetrics.length, (index) {
                      final globalIndex = index + 2;
                      return Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 0 : 12),
                        child: _StaggeredMetricCard(
                          staggerController: _staggerController,
                          index: globalIndex,
                          child: _buildMetricCard(
                            context,
                            extraMetrics[index],
                            globalIndex,
                            isLast: globalIndex == metrics.length - 1,
                          ),
                        ),
                      );
                    }),
                  )
                : const SizedBox(
                    key: ValueKey<String>('collapsed_extra_metrics'),
                  ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    UserMetric metric,
    int index, {
    bool isLast = false,
  }) {
    final badgeColor = metric.bmiBadgeColor;
    final pc = ProductColor.instance;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [pc.seedColor.withAlpha(185), pc.lightPurple.withAlpha(165)],
        ),
        borderRadius: const ProductRadius.fourteen(),
        border: Border.all(color: pc.cardBorder),
        boxShadow: [
          BoxShadow(
            color: pc.chartGradientEnd.withAlpha(45),
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: badgeColor.withAlpha(55),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              border: Border(
                bottom: BorderSide(color: badgeColor.withAlpha(80)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: badgeColor.withAlpha(180),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  metric.userMetric?.result.tr() ?? '-',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: badgeColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const Spacer(),
                Icon(
                  ProductIcon.calendar.icon,
                  size: 13,
                  color: pc.white,
                ),
                const SizedBox(width: 5),
                Text(
                  metric.displayDate,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: pc.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _MetricChip(
                        icon: ProductIcon.weight.icon,
                        label: LocaleKeys.home_weight.tr(),
                        value: metric.weight != null
                            ? '${metric.weight!.toStringAsFixed(1)} kg'
                            : '-',
                        accentColor: pc.teal,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MetricChip(
                        icon: ProductIcon.chart.icon,
                        label: LocaleKeys.home_bmi.tr(),
                        value: metric.bmi?.toStringAsFixed(2) ?? '-',
                        accentColor: badgeColor,
                      ),
                    ),
                  ],
                ),

                if (!isLast) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: metric.weightDiffColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: metric.weightDiffColor.withAlpha(60),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          metric.resultIcon,
                          size: 15,
                          color: metric.weightDiffColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          LocaleKeys.home_weight_change.tr(),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: pc.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          metric.weightDiffLabel,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: metric.weightDiffColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 10),
                _BmiRangeIndicator(bmi: metric.bmi, result: metric.userMetric),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
final class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: ProductColor.instance.whiteAlpha20,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: accentColor),
              const SizedBox(width: 5),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: ProductColor.instance.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              color: ProductColor.instance.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _StaggeredMetricCard extends StatelessWidget {
  const _StaggeredMetricCard({
    required this.staggerController,
    required this.index,
    required this.child,
  });

  final AnimationController staggerController;
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.15).clamp(0.0, 0.85);
    final end = (start + 0.5).clamp(0.0, 1.0);

    final fadeAnim = CurvedAnimation(
      parent: staggerController,
      curve: Interval(start, end, curve: Curves.easeOut),
    );

    final slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: staggerController,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          ),
        );

    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(position: slideAnim, child: child),
    );
  }
}

@immutable
final class _BmiRangeIndicator extends StatelessWidget {
  const _BmiRangeIndicator({required this.bmi, required this.result});

  final double? bmi;
  final BodyMetricResult? result;

  static const double _min = 10;
  static const double _max = 45;
  static const double _t1 = 18.5;
  static const double _t2 = 25;
  static const double _t3 = 30;
  static const double _t4 = 40;

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
                  color: pc.white,
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
