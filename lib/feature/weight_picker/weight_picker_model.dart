part of 'weight_picker.dart';

mixin WeightPickerModel on State<_WeightPickerBody> {
  late final PageController _weightController;
  late final PageController _decimalWeightController;
  final TextEditingController _weightTextController = TextEditingController();

  int _selectedWeight = 62;
  int _selectedDecimalWeight = 0;

  final double _decimalMaxWeight = 10;
  final double _maxWeight = 636;

  final double _decimalMinWeight = 0;
  final double _minWeight = 25;

  @override
  void initState() {
    super.initState();
    _weightTextController.text = '$_selectedWeight';
    _weightController = PageController(
      initialPage: _selectedWeight - _minWeight.toInt(),
      viewportFraction: 0.20,
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
    final position = _decimalWeightController.page!;
    if (position != _selectedDecimalWeight) {
      setState(() {
        _selectedDecimalWeight = position.round();
        trackAndSetWeight();
      });
    }
  }

  void trackAndSetWeight() {}
  void trackAndSetDecimalWeight() {}
}
