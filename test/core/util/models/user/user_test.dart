import 'package:bodymetrics/core/enum/gender_value.dart';
import 'package:bodymetrics/core/util/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const user = User(
      id: 1,
      name: 'John',
      surname: 'Doe',
      avatar: 'avatar.png',
      gender: GenderValue.male,
      height: 180,
      birthOfDate: '1990-01-01',
    );

    test('supports value equality', () {
      expect(
        user,
        const User(
          id: 1,
          name: 'John',
          surname: 'Doe',
          avatar: 'avatar.png',
          gender: GenderValue.male,
          height: 180,
          birthOfDate: '1990-01-01',
        ),
      );
    });

    test('props are correct', () {
      // User props: [name, gender, id, birthOfDate, surname]
      // Note: height and avatar are NOT in props in the source code provided!
      expect(user.props, [
        'John', // name
        GenderValue.male, // gender
        1, // id
        '1990-01-01', // birthOfDate
        'Doe', // surname
      ]);
    });

    test('copyWith creates a new instance with updated values', () {
      final updated = user.copyWith(name: 'Jane');
      expect(updated.name, 'Jane');
      expect(updated.id, user.id);
    });

    test('fromJson creates correct instance', () {
      final json = <String, dynamic>{
        'id': 1,
        'name': 'John',
        'surname': 'Doe',
        'avatar': 'avatar.png',
        'gender': 'male',
        'height': 180,
        'birthOfDate': '1990-01-01',
      };

      expect(User.fromJson(json), user);
    });

    test('toJson creates correct map', () {
      final json = user.toJson();
      expect(json, {
        'id': 1,
        'name': 'John',
        'surname': 'Doe',
        'avatar': 'avatar.png',
        'gender': 'male',
        'height': 180,
        'birthOfDate': '1990-01-01',
      });
    });
  });
}
