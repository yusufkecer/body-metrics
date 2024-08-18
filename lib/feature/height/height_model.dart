part of 'height.dart';

mixin HeightModel on State<_HeightBody> {
  late PageController _pageController;

  HeightSelectorCubit? cubit;

  late int _currentCentimeter;
  late final int _maxValue;
  late final int _minValue;
  late String? _lottie;

  @override
  void initState() {
    cubit = context.read<HeightSelectorCubit>();
    if (cubit.isNull) {
      throw Exception('cubit is null');
    }
    _currentCentimeter = 165;
    _maxValue = cubit!._maxValue;
    _minValue = cubit!._minValue;
    cubit!.updateHeight(_currentCentimeter.toDouble());
    _initValues();
    _pageController = PageController(viewportFraction: 0.15, initialPage: _currentCentimeter - _minValue);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onPageChanged();
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onPageChanged() async {
    _pageController.addListener(() {
      final page = _pageController.page!;
      cubit!.updateHeight(page);
    });
  }

  void _initValues() {
    _lottie = widget.isFemale == true ? AssetValue.femaleBody.value : AssetValue.maleBody.value;
  }
}
