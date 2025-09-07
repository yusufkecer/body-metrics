part of 'height_picker.dart';

mixin _HeightModel on State<_HeightBody>, DialogUtil<_HeightBody>, SaveAppMixin {
  late PageController _pageController;

  HeightSelectorCubit? cubit;

  late double _currentCentimeter;
  final int _maxValue = _HeightValues.maxValue.value;
  final int _minValue = _HeightValues.minValue.value;
  late final String? _lottie;

  @override
  void initState() {
    super.initState();

    cubit = context.read<HeightSelectorCubit>();

    _currentCentimeter = _PickerValues.currentValue.value;

    _initValues();
    _pageController = PageController(
      viewportFraction: _PickerValues.viewportFraction.value,
      initialPage: _currentCentimeter.toInt() - _minValue,
    );

    _pageController.addListener(_onPageChanged);

    cubit?.updateHeight(_pageController.initialPage.toDouble(), _minValue, _maxValue);
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();

    super.dispose();
  }

  void _onPageChanged() {
    final page = _pageController.page;
    if (page == null) return;
    cubit!.updateHeight(page, _minValue, _maxValue);
  }

  Future<void> _onSaved() async {
    if (cubit == null) return;
    final heightState = cubit!.state;
    if (heightState.height.isNullOrEmpty) return;
    final saveHeightCubit = Locator.sl<SaveHeightCubit>();
    await saveHeightCubit.saveHeight(heightState.userHeight!);
    if (saveHeightCubit.state case SaveHeightError(:final error)) {
      showLottieError(error);
      return;
    }
    await saveApp(Pages.weightPage);
    if (!mounted) return;
    _pushToWeight();
  }

  void _pushToWeight() {
    context.pushRoute(const WeightView());
  }

  void _initValues() {
    _lottie = widget.isFemale == true ? AssetValue.femaleBody.value : AssetValue.maleBody.value;
  }
}
