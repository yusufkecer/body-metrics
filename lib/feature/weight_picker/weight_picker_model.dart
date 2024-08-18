part of 'weight_picker.dart';

mixin WeightPickerModel on State<_WeightPickerBody> {
  late final PageController _weightController;
  late final PageController _decimalWeightController;
  final TextEditingController _weightTextController = TextEditingController(text: '62');
  int _selectedWeight = 62;

  @override
  void initState() {
    super.initState();
    _weightController = PageController(
      initialPage: _selectedWeight,
      viewportFraction: 0.14,
    );
    _decimalWeightController = PageController(
      viewportFraction: 0.14,
    );

    _weightController.addListener(_onChangeWeight);
    _decimalWeightController.addListener(_onChangeDecimalWeight);
  }

  @override
  void dispose() {
    _weightController
      ..removeListener(_onChangeWeight)
      ..dispose();

    _decimalWeightController
      ..removeListener(_onChangeDecimalWeight)
      ..dispose();

    _weightTextController.dispose();
    super.dispose();
  }

  void _onChangeWeight() {
    final position = _weightController.page!.round();
    if (position != _selectedWeight) {
      setState(() {
        _selectedWeight = position;
        trackAndSetWeight();
      });
    }
  }

  void _onChangeDecimalWeight() {
    final position = _weightController.page!.round();
    if (position != _selectedWeight) {
      setState(() {
        _selectedWeight = position;
        trackAndSetWeight();
      });
    }
  }

  void trackAndSetWeight() {}
}
