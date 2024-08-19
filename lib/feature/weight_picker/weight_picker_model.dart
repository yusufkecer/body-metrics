part of 'weight_picker.dart';

mixin WeightPickerModel on State<_WeightPickerBody>, DialogUtil {
  late final PageController _weightController;
  late final PageController _decimalWeightController;
  final TextEditingController _weightTextController = TextEditingController();

  int _selectedWeight = 62;
  int _selectedDecimalWeight = 0;

  final double _maxWeight = 636;
  final double _minWeight = 25;

  final double _decimalMinWeight = 0;
  final double _decimalMaxWeight = 10;

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
        _selectedWeight = position + _minWeight.toInt();
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

  void trackAndSetWeight() {
    if (_selectedDecimalWeight > 0) {
      _weightTextController.text = '$_selectedWeight.$_selectedDecimalWeight';
      return;
    }
    _weightTextController.text = '$_selectedWeight';
  }

  void _fieldFocus(bool hasFocus) {
    try {
      if (!hasFocus) {
        final text = _weightTextController.text;

        final lastValue = text[text.length - 1];
        if (lastValue.isEmpty) {
          showLottieError(LocaleKeys.weight_weight_empty.tr());
          _weightTextController.text = '$_selectedWeight';
        }
        if (lastValue == '.' || lastValue == '.0') {
          _weightTextController.text = text.substring(0, text.length - 1);
        }
        final parsedWeight = double.parse(_weightTextController.text);
        if (parsedWeight > _maxWeight || parsedWeight < _minWeight) {
          showLottieError(LocaleKeys.weight_enter_range.tr());
          _weightTextController.text = '$_selectedWeight';
        }
      }
    } catch (e) {
      showLottieError(LocaleKeys.weight_weight_invalid.tr());
      _weightTextController.text = '$_selectedWeight';
    }
  }

  void _textFieldChange(String value) {
    if (value.isValidNumber) {
      _weightTextController.text = value;
      if (value.isNotEmpty) {}
    } else {
      _weightTextController.text = '$_selectedWeight';
    }
  }
}
