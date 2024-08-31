import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';

enum BmiResult { underweight, normal, overweight, obese, morbidlyObese, unknown }

extension ResultExtension on BmiResult {
  String get result {
    switch (this) {
      case BmiResult.underweight:
        return LocaleKeys.bmi_result_under_weight.tr();
      case BmiResult.normal:
        return LocaleKeys.bmi_result_normal.tr();
      case BmiResult.overweight:
        return LocaleKeys.bmi_result_over_weight.tr();
      case BmiResult.obese:
        return LocaleKeys.bmi_result_obese.tr();
      case BmiResult.morbidlyObese:
        return LocaleKeys.bmi_result_severely_obese.tr();
      case BmiResult.unknown:
        return LocaleKeys.bmi_result_unkown.tr();
    }
  }
}

extension ParseExtension on int {
  BmiResult get resultParse {
    switch (this) {
      case 0:
        return BmiResult.underweight;
      case 1:
        return BmiResult.normal;
      case 2:
        return BmiResult.overweight;
      case 3:
        return BmiResult.obese;
      case 4:
        return BmiResult.morbidlyObese;
      default:
        return BmiResult.unknown;
    }
  }
}
