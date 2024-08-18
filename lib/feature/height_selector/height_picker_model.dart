part of 'height_picker.dart';

mixin HeightModel on State<_HeightBody> {
  late PageController _pageController;

  HeightSelectorCubit? cubit;

  late double _currentCentimeter;
  final int _maxValue = 252;
  final int _minValue = 65;
  late String? _lottie;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<HeightSelectorCubit>();

    _currentCentimeter = 165;

    _initValues();
    _pageController = PageController(
      viewportFraction: 0.15,
      initialPage: _currentCentimeter.toInt() - _minValue,
    );

    cubit.updateHeight(_pageController.initialPage.toDouble(), _minValue, _maxValue);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onPageChanged();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onPageChanged() async {
    _pageController.addListener(() {
      final page = _pageController.page!;
      cubit!.updateHeight(page, _minValue, _maxValue);
    });
  }

  void _initValues() {
    _lottie = widget.isFemale == true ? AssetValue.femaleBody.value : AssetValue.maleBody.value;
  }
}
