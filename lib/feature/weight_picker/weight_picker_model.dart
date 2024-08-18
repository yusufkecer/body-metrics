part of 'weight_picker.dart';

mixin WeightPickerModel on State<_WeightPickerBody> {
  late final PageController _weightPickerController;
  int _selectedWeight = 62;

  @override
  void initState() {
    super.initState();
    _weightPickerController = PageController(
      initialPage: _selectedWeight,
      viewportFraction: 0.14,
    );

    _weightPickerController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _weightPickerController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final position = _weightPickerController.page!.round();
    if (position != _selectedWeight) {
      setState(() {
        _selectedWeight = position;
        trackAndSetWeight();
      });
    }
  }

  void trackAndSetWeight() {}
}
