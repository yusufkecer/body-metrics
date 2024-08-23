import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';

enum BMIResult { underweight, normal, overweight, obese, morbidlyObese, unknown }

extension ResultExtension on BMIResult {
  String get result {
    switch (this) {
      case BMIResult.underweight:
        return LocaleKeys.bmi_result_under_weight.tr();
      case BMIResult.normal:
        return LocaleKeys.bmi_result_normal.tr();
      case BMIResult.overweight:
        return LocaleKeys.bmi_result_over_weight.tr();
      case BMIResult.obese:
        return LocaleKeys.bmi_result_obese.tr();
      case BMIResult.morbidlyObese:
        return LocaleKeys.bmi_result_severely_obese.tr();
      case BMIResult.unknown:
        return LocaleKeys.bmi_result_unkown.tr();
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
