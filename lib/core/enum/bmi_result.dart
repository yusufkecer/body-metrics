///[BMIResult] types 1 underweight 2 normal 3 overweight 4 obese 5 morbidlyObese 6 unknown
enum BMIResult {
  underweight,
  normal,
  overweight,
  obese,
  morbidlyObese,
  unknown
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
      case BMIResult.unknown:
        return 'Unknown';
    }
  }
}

extension ParseExtension on int {
  BMIResult get resultParse {
    switch (this) {
      case 0:
        return BMIResult.underweight;
      case 1:
        return BMIResult.normal;
      case 2:
        return BMIResult.overweight;
      case 3:
        return BMIResult.obese;
      case 4:
        return BMIResult.morbidlyObese;
      default:
        return BMIResult.unknown;
    }
  }
}
