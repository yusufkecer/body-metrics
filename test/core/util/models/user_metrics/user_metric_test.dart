import 'package:bodymetrics/core/enum/bmi_result.dart';
import 'package:bodymetrics/core/util/models/user_metrics/user_metric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserMetric', () {
    const userMetric = UserMetric(
      id: 1,
      userId: 1,
      date: '2023-01-01',
      weight: 70,
      bmi: 22,
      weightDiff: -1,
      userMetric: BodyMetricResult.normal,
      height: 175,
      createdAt: '2023-01-01T00:00:00',
    );

    test('supports value equality', () {
      expect(
        userMetric,
        const UserMetric(
          id: 1,
          userId: 1,
          date: '2023-01-01',
          weight: 70,
          bmi: 22,
          weightDiff: -1,
          userMetric: BodyMetricResult.normal,
          height: 175,
          createdAt: '2023-01-01T00:00:00',
        ),
      );
    });

    test('props are correct', () {
      expect(userMetric.props, [
        1, // id
        '2023-01-01', // date
        70.0, // weight
        BodyMetricResult.normal, // userMetric
        22.0, // bmi
        -1.0, // weightDiff
        1, // userId
        175, // height
        '2023-01-01T00:00:00', // createdAt
      ]);
    });

    test('copyWith creates a new instance with updated values', () {
      final updated = userMetric.copyWith(weight: 75);
      expect(updated.weight, 75.0);
      expect(updated.id, userMetric.id);
    });

    test('fromJson creates correct instance', () {
      final json = <String, dynamic>{
        'id': 1,
        'user_id': 1,
        'date': '2023-01-01',
        'weight': 70.0,
        'bmi': 22.0,
        'weight_diff': -1.0,
        'body_metric': 'normal',
        'height': 175,
        'created_at': '2023-01-01T00:00:00',
      };

      expect(UserMetric.fromJson(json), userMetric);
    });

    test('toJson creates correct map', () {
      final json = userMetric.toJson();
      expect(json, {
        'id': 1,
        'user_id': 1,
        'date': '2023-01-01',
        'weight': 70.0,
        'bmi': 22.0,
        'weight_diff': -1.0,
        'body_metric': 'normal',
        'height': 175,
        'created_at': '2023-01-01T00:00:00',
      });
    });
  });
}
