import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/save_height_cubit/save_height_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';

part 'cubit/height_selector_cubit/height_picker_cubit.dart';
part 'cubit/height_selector_cubit/height_picker_state.dart';
part 'enum/height_values.dart';
part 'height_picker_model.dart';
part 'widgets/ruler.dart';

@RoutePage(name: 'HeightView')
@immutable
final class HeightPicker extends StatefulWidget {
  const HeightPicker({
    required this.gender,
    super.key,
  });

  final GenderValue gender;

  @override
  State<HeightPicker> createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> with SaveAppMixin, DialogUtil<HeightPicker>, _HeightModel {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<HeightSelectorCubit>(),
      child: Builder(
        builder: (context) {
          return GradientScaffold(
            appBar: CustomAppBar(
              title: LocaleKeys.height_select_height,
              action: ColorfulTextButton(
                text: LocaleKeys.cont,
                onTap: _onSaved,
              ),
            ),
            body: _HeightBody(
              isFemale: widget.gender.isFemale(),
              cubit: cubit,
              pageController: _pageController,
              maxValue: _maxValue,
              minValue: _minValue,
              selectedHeight: cubit!.state.page,
              lottie: _lottie!.lottie,
            ),
          );
        },
      ),
    );
  }
}

@immutable
final class _HeightBody extends StatelessWidget {
  const _HeightBody({
    required this.isFemale,
    required this.cubit,
    required this.pageController,
    required this.maxValue,
    required this.minValue,
    required this.selectedHeight,
    required this.lottie,
  });

  final bool isFemale;
  final HeightSelectorCubit? cubit;
  final PageController? pageController;
  final int? maxValue;
  final int? minValue;
  final int? selectedHeight;
  final String? lottie;

  @override
  Widget build(BuildContext context) {
    if (cubit == null) {
      return const CustomError();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        Lottie.asset(
          lottie!.lottie,
          height: cubit!.state.height,
        ),
        _Ruler(
          pageController: pageController!,
          maxValue: maxValue!,
          minValue: minValue!,
          selectedHeight: selectedHeight!,
        ),
      ],
    );
  }
}
