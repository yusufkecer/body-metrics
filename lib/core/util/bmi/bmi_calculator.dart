import 'package:bodymetrics/core/index.dart';
import 'package:flutter/foundation.dart';

/// A utility class for BMI calculations and category classification
@immutable
final class BmiCalculator {
  const BmiCalculator._();

  /// Calculate BMI from weight (kg) and height (m)
  static Future<double> calculateBmi(double weight, double height) async {
    if (weight <= 0 || height <= 0) {
      throw ArgumentError('Weight and height must be positive values');
    }

    return await compute(_calculateBmiValue, {'weight': weight, 'height': height});
  }

  /// Calculate BMI synchronously
  static double calculateBmiSync(double weight, double height) {
    if (weight <= 0 || height <= 0) {
      throw ArgumentError('Weight and height must be positive values');
    }

    return weight / (height * height);
  }

  /// Get BMI category based on BMI value
  static BodyMetricResult getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return BodyMetricResult.underweight;
    } else if (bmi < 25.0) {
      return BodyMetricResult.normal;
    } else if (bmi < 30.0) {
      return BodyMetricResult.overweight;
    } else if (bmi < 35.0) {
      return BodyMetricResult.obese;
    } else if (bmi >= 35.0) {
      return BodyMetricResult.morbidlyObese;
    } else {
      return BodyMetricResult.unknown;
    }
  }

  /// Calculate BMI and return category result
  static Future<BmiResult> calculateBmiWithCategory(double weight, double height) async {
    final bmi = await calculateBmi(weight, height);
    final category = getBmiCategory(bmi);
    
    return BmiResult(bmi: bmi, category: category);
  }

  /// Internal method for compute isolation
  static double _calculateBmiValue(Map<String, double> data) {
    final weight = data['weight']!;
    final height = data['height']!;
    return weight / (height * height);
  }
}

/// Result object containing BMI value and category
@immutable
final class BmiResult {
  const BmiResult({
    required this.bmi,
    required this.category,
  });

  final double bmi;
  final BodyMetricResult category;
}