part of 'height.dart';

mixin HeightModel on State<Height> {
  late PageController _pageController;

  int _currentCentimeter = 165;
  final int _maxValue = 252;
  final int _minValue = 65;
  double _selectedHeight = 165;

  late String? _lottie;
  @override
  void initState() {
    _initValues();
    _pageController = PageController(viewportFraction: 0.1, initialPage: _currentCentimeter - _minValue);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onPageChanged();
    });

    super.initState();
  }

  Future<void> _onPageChanged() async {
    _pageController.addListener(() {
      Future.microtask(() {
        final position = _pageController.page!.floor() + _minValue;
        if (position != _currentCentimeter && position >= _minValue && position <= _maxValue) {
          _currentCentimeter = position;
          _selectedHeight = ((_currentCentimeter * 2) * (_maxValue - _minValue)) / 233;
          'current $_currentCentimeter'.w;
        }
      });
    });
  }

  void _initValues() {
    _selectedHeight = ((_currentCentimeter * 2) * (_maxValue - _minValue)) / 233;
    _lottie = widget.isFemale == true ? AssetValue.femaleBody.value : AssetValue.maleBody.value;
  }
}
