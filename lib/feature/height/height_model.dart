part of 'height.dart';

mixin HeightModel on State<Height> {
  final PageController _pageController = PageController();
  int _currentCentimeter = 165;

  final int _maxValue = 100;

  double _selectedHeight = 165;
  String? _lottie;
  @override
  void initState() {
    _lottie = widget.isFemale == true ? AssetValue.femaleBody.value : AssetValue.maleBody.value;
    _pageController.addListener(() {
      setState(() {
        final position = _pageController.page!.floor();

        if (position != _currentCentimeter) {
          _currentCentimeter = position;
          _selectedHeight = ((_currentCentimeter * 2.935) * _maxValue) / 529.2;
        }
      });
    });
    super.initState();
  }
}
