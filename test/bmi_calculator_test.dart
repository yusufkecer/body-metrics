import 'package:bodymetrics/core/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BmiCalculator', () {
    group('calculateBmiSync', () {
      test('should calculate BMI correctly for normal values', () {
        // Arrange
        const weight = 70.0; // kg
        const height = 1.75; // m
        const expectedBmi = 22.86; // 70 / (1.75 * 1.75)

        // Act
        final result = BmiCalculator.calculateBmiSync(weight, height);

        // Assert
        expect(result, closeTo(expectedBmi, 0.01));
      });

      test('should throw ArgumentError for zero weight', () {
        // Arrange
        const weight = 0.0;
        const height = 1.75;

        // Act & Assert
        expect(
          () => BmiCalculator.calculateBmiSync(weight, height),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw ArgumentError for negative height', () {
        // Arrange
        const weight = 70.0;
        const height = -1.75;

        // Act & Assert
        expect(
          () => BmiCalculator.calculateBmiSync(weight, height),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('getBmiCategory', () {
      test('should return underweight for BMI < 18.5', () {
        // Arrange
        const bmi = 17.0;

        // Act
        final result = BmiCalculator.getBmiCategory(bmi);

        // Assert
        expect(result, BodyMetricResult.underweight);
      });

      test('should return normal for BMI between 18.5 and 24.9', () {
        // Arrange
        const bmi = 22.0;

        // Act
        final result = BmiCalculator.getBmiCategory(bmi);

        // Assert
        expect(result, BodyMetricResult.normal);
      });

      test('should return overweight for BMI between 25.0 and 29.9', () {
        // Arrange
        const bmi = 27.0;

        // Act
        final result = BmiCalculator.getBmiCategory(bmi);

        // Assert
        expect(result, BodyMetricResult.overweight);
      });

      test('should return obese for BMI between 30.0 and 34.9', () {
        // Arrange
        const bmi = 32.0;

        // Act
        final result = BmiCalculator.getBmiCategory(bmi);

        // Assert
        expect(result, BodyMetricResult.obese);
      });

      test('should return morbidlyObese for BMI >= 35.0', () {
        // Arrange
        const bmi = 40.0;

        // Act
        final result = BmiCalculator.getBmiCategory(bmi);

        // Assert
        expect(result, BodyMetricResult.morbidlyObese);
      });
    });

    group('calculateBmi', () {
      test('should calculate BMI correctly using isolate', () async {
        // Arrange
        const weight = 70.0;
        const height = 1.75;
        const expectedBmi = 22.86;

        // Act
        final result = await BmiCalculator.calculateBmi(weight, height);

        // Assert
        expect(result, closeTo(expectedBmi, 0.01));
      });

      test('should throw ArgumentError for invalid inputs', () async {
        // Arrange
        const weight = 0.0;
        const height = 1.75;

        // Act & Assert
        expect(
          () async => await BmiCalculator.calculateBmi(weight, height),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('calculateBmiWithCategory', () {
      test('should return correct BMI and category', () async {
        // Arrange
        const weight = 70.0;
        const height = 1.75;

        // Act
        final result = await BmiCalculator.calculateBmiWithCategory(weight, height);

        // Assert
        expect(result.bmi, closeTo(22.86, 0.01));
        expect(result.category, BodyMetricResult.normal);
      });
    });

    group('BmiResult', () {
      test('should create result with BMI and category', () {
        // Arrange
        const bmi = 22.86;
        const category = BodyMetricResult.normal;

        // Act
        const result = BmiResult(bmi: bmi, category: category);

        // Assert
        expect(result.bmi, bmi);
        expect(result.category, category);
      });
    });
  });
}