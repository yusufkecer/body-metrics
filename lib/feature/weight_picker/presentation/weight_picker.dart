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
      bloc: Locator.sl<WeightPickerCubit>(),
      builder: (context, weightPickerCubit) {
        return GradientScaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.weight_select_weight,
            action: ColorfulTextButton(
              text: LocaleKeys.cont,
              onTap: () async {
                await saveApp(Pages.homePage);
                await weightPickerCubit.saveBodyMetrics();
                await _goToHomeView();
              },
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: _IndicatorClipper(),
                    child: ClipRRect(
                      child: Container(
                        height: context.weightIndicatorHeight,
                        width: context.weightIndicatorWidth,
                        padding: ProductPadding.ten(),
                        decoration: BoxDecoration(
                          color: ProductColor.instance.seedColor,
                          borderRadius: const ProductRadius.ten(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _WeightIndicator(
                              weightTextController: _weightTextController,
                              fieldFocus: ({bool? value}) =>
                                  _fieldFocus(value ?? false),
                              textFieldChange: _textFieldChange,
                            ),
                            _WeightPickerWidget(
                              weightPickerController: _weightController,
                              minVal: _minWeight,
                              selectedWeight: _selectedWeight,
                              maxVal: _maxWeight,
                              isDisabled: _isFocused,
                            ),
                            _WeightPickerWidget(
                              weightPickerController: _decimalWeightController,
                              minVal: _minVal,
                              selectedWeight: _selectedDecimalWeight,
                              maxVal: _decimalMaxWeight,
                              isDisabled: _isFocused,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// @immutable
// final class _WeightPickerBody extends StatefulWidget {
//   const _WeightPickerBody();
//
//   @override
//   State<_WeightPickerBody> createState() => __WeightPickerBodyState();
// }
//
// class __WeightPickerBodyState extends State<_WeightPickerBody>
//     with DialogUtil, _WeightPickerModel {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

/*
* final class WeightPicker extends StatelessWidget with SaveAppMixin {
  const WeightPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Locator.sl<WeightPickerCubit>(),
      child: Builder(
        builder: (context) {
          return GradientScaffold(
            appBar: CustomAppBar(
              title: LocaleKeys.weight_select_weight,
              action: ColorfulTextButton(
                text: LocaleKeys.cont,
                onTap: () async {
                  await saveApp(Pages.homePage);
                  await context.read<WeightPickerCubit>().saveBodyMetrics();
                  await context.pushRoute(const HomeView());
                },
              ),
            ),
            body: const _WeightPickerBody(),
          );
        },
      ),
    );
  }
}
* */
