part of 'weight_picker.dart';

mixin _WeightPickerModel on State<_WeightPickerBody>, DialogUtil {
  late final PageController _weightController;
  late final PageController _decimalWeightController;
  final TextEditingController _weightTextController = TextEditingController();
  bool _isFocused = false;
  final _minVal = 0.0;

  int _selectedWeight = 70;
  int _selectedDecimalWeight = 0;

  final double _maxWeight = 636;
  final double _minWeight = 25;

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
    if (hasFocus) {
      _isFocused = true;
      return;
    } else {
      _isFocused = false;
    }

    final text = _weightTextController.text;

    if (text.isEmpty) {
      _handleEmptyWeight();
      return;
    }

    try {
      _handleTextEditing(text);
    } catch (e) {
      _handleInvalidWeight();
    }
  }

  void _handleEmptyWeight() {
    _setWeightText(_selectedWeight.toDouble());
    showLottieError(LocaleKeys.weight_weight_empty);
  }

  void _handleTextEditing(String text) {
    final lastValue = text.isNotEmpty ? text[text.length - 1] : '';
    final lastSecondValue = text.length > 1 ? text[text.length - 2] : '';

    if (lastValue == '.') {
      _weightTextController.text = text.substring(0, text.length - 1);
    } else if (lastSecondValue == '.' && lastValue == '0') {
      _weightTextController.text = text.substring(0, text.length - 2);
    }

    final parsedWeight = double.tryParse(_weightTextController.text) ?? 0;

    if (parsedWeight > _maxWeight || parsedWeight < _minWeight) {
      _handleWeightOutOfRange();
    } else {
      _updateWeightAndDecimalController(parsedWeight, text);
    }
  }

  void _handleWeightOutOfRange() {
    _setWeightText(_selectedWeight.toDouble());
    showLottieError(LocaleKeys.weight_enter_range);
  }

  void _handleInvalidWeight() {
    _setWeightText(_selectedWeight.toDouble());
    showLottieError(LocaleKeys.weight_weight_invalid);
  }

  void _updateWeightAndDecimalController(double parsedWeight, String text) {
    var value = text.convert;
    var integer = parsedWeight.toInt() - _minWeight.toInt();

    if (value > 9) {
      integer++;
      value = 0;
    }

    _decimalWeightController.animateToPage(
      value,
      duration: Durations.medium3,
      curve: Curves.fastOutSlowIn,
    );

    _weightController.animateToPage(
      integer,
      duration: Durations.medium3,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _setWeightText(double weight, {bool isDecimal = false}) {
    if (!isDecimal) {
      _weightTextController.text = weight.toStringAsFixed(0);
      return;
    }
    _weightTextController.text = weight.toString();
  }

  void _textFieldChange(String value) {
    if (!value.isValidNumber) {
      _weightTextController.text = '$_selectedWeight';
    }
  }
}
