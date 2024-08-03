enum BMIResult {
  underweight,
  normal,
  overweight,
  obese,
  morbidlyObese;
}

extension ResultExtension on BMIResult {
  String get result {
    switch (this) {
      case BMIResult.underweight:
        return 'Underweight';
      case BMIResult.normal:
        return 'Normal';
      case BMIResult.overweight:
        return 'Overweight';
      case BMIResult.obese:
        return 'Obese';
      case BMIResult.morbidlyObese:
        return 'Morbidly Obese';
    }
  }
}
