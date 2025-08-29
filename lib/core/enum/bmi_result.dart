import 'package:bodymetrics/core/index.dart';

enum BodyMetricResult { underweight, normal, overweight, obese, morbidlyObese, unknown }

extension ResultExtension on BodyMetricResult {
  String get result {
    switch (this) {
      case BodyMetricResult.underweight:
        return LocaleKeys.bmi_result_under_weight;
      case BodyMetricResult.normal:
        return LocaleKeys.bmi_result_normal;
      case BodyMetricResult.overweight:
        return LocaleKeys.bmi_result_over_weight;
      case BodyMetricResult.obese:
        return LocaleKeys.bmi_result_obese;
      case BodyMetricResult.morbidlyObese:
        return LocaleKeys.bmi_result_severely_obese;
      case BodyMetricResult.unknown:
        return LocaleKeys.bmi_result_unknown;
    }
  }
}

extension ParseExtension on int {
  BodyMetricResult get resultParse {
    switch (this) {
      case 0:
        return BodyMetricResult.underweight;
      case 1:
        return BodyMetricResult.normal;
      case 2:
        return BodyMetricResult.overweight;
      case 3:
        return BodyMetricResult.obese;
      case 4:
        return BodyMetricResult.morbidlyObese;
      default:
        return BodyMetricResult.unknown;
    }
  }
}
