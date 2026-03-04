import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'weight_picker_model.dart';

part 'widgets/weight_picker.dart';

part 'widgets/weight_indicator.dart';

part 'widgets/indicator_clipper.dart';

part 'extension/value_extension.dart';

@RoutePage(name: 'WeightView')
@immutable
final class WeightPicker extends StatefulWidget {
  const WeightPicker({super.key});

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker>
    with SaveAppMixin, DialogUtil, _WeightPickerModel {
  @override
  Widget build(BuildContext context) {
    return BlocWrapper<WeightPickerCubit, WeightPickerState>(
      create: (context) => Locator.sl<WeightPickerCubit>(),
      builder: (context, weightPickerCubit) {
        _cubit = weightPickerCubit;
        final indicatorHeight = (context.height * 0.46).clamp(320.0, 420.0);
        final indicatorWidth = (context.width * 0.74).clamp(250.0, 340.0);

        return GradientScaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const ProductPadding.authForm(),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.router.maybePop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ProductColor.instance.whiteAlpha20,
                            borderRadius: const ProductRadius.twelve(),
                            border: Border.all(
                              color: ProductColor.instance.whiteAlpha40,
                            ),
                          ),
                          child: Icon(
                            ProductIcon.backArrow.icon,
                            color: ProductColor.instance.white,
                            size: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        AppUtil.appName,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: ProductColor.instance.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      HorizontalSpace.s(),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ProductColor.instance.whiteAlpha20,
                          border: Border.all(
                            color: ProductColor.instance.whiteAlpha50,
                          ),
                        ),
                        child: Icon(
                          ProductIcon.heartMonitor.icon,
                          color: ProductColor.instance.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalSpace.l(),
                Expanded(
                  child: Padding(
                    padding: ProductPadding.horizontalTwentyFour(),
                    child: AuthFormLayout(
                      title: LocaleKeys.weight_select_weight.tr(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: ClipPath(
                              clipper: _IndicatorClipper(),
                              child: ClipRRect(
                                child: Container(
                                  height: indicatorHeight,
                                  width: indicatorWidth,
                                  padding: ProductPadding.ten(),
                                  decoration: BoxDecoration(
                                    color: ProductColor.instance.seedColor,
                                    borderRadius: const ProductRadius.ten(),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _WeightIndicator(
                                        weightTextController:
                                            _weightTextController,
                                        fieldFocus: ({bool? value}) =>
                                            _fieldFocus(value ?? false),
                                        textFieldChange: _textFieldChange,
                                      ),
                                      _WeightPickerWidget(
                                        weightPickerController:
                                            _weightController,
                                        minVal: _minWeight,
                                        selectedWeight: _selectedWeight,
                                        maxVal: _maxWeight,
                                        isDisabled: _isFocused,
                                        height: 58,
                                      ),
                                      _WeightPickerWidget(
                                        weightPickerController:
                                            _decimalWeightController,
                                        minVal: _minVal,
                                        selectedWeight: _selectedDecimalWeight,
                                        maxVal: _decimalMaxWeight,
                                        isDisabled: _isFocused,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          VerticalSpace.l(),
                          CustomFilled(
                            text: LocaleKeys.cont,
                            onPressed: _saveAndPush,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
