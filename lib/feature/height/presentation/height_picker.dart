import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/save_height_cubit/save_height_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

part 'enum/height_values.dart';
part 'height_picker_model.dart';
part 'widgets/ruler.dart';

@RoutePage(name: 'HeightView')
@immutable
final class HeightPicker extends StatelessWidget {
  const HeightPicker({
    required this.gender,
    super.key,
  });

  final GenderValue gender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<HeightSelectorCubit>(),
      child: Builder(
        builder: (context) {
          return _HeightBody(
            isFemale: gender.isFemale(),
          );
        },
      ),
    );
  }
}

@immutable
final class _HeightBody extends StatefulWidget {
  const _HeightBody({
    required this.isFemale,
  });

  final bool isFemale;

  @override
  State<_HeightBody> createState() => _HeightBodyState();
}

class _HeightBodyState extends State<_HeightBody> with SaveAppMixin, DialogUtil<_HeightBody>, _HeightModel {
  @override
  Widget build(BuildContext context) {
    cubit = context.watch<HeightSelectorCubit>();
    if (cubit == null) {
      return const CustomError();
    }
    return GradientScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.height_select_height,
        action: ColorfulTextButton(
          text: LocaleKeys.cont,
          onTap: _onSaved,
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          RepaintBoundary(
            child: Lottie.asset(
              _lottie!.lottie,
              height: cubit!.state.height,
            ),
          ),
          _Ruler(
            pageController: _pageController,
            maxValue: _maxValue,
            minValue: _minValue,
            selectedHeight: cubit!.state.userHeight!,
          ),
        ],
      ),
    );
  }
}
