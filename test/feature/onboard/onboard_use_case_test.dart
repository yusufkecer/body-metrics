import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/onboard/domain/use_case/onboard_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: must_be_immutable
class FakeOnboardRepository implements Repository<int, AppModel> {
  FakeOnboardRepository() : super();
  int returnValue = 0;
  Exception? exception;
  List<AppModel?> calls = [];

  @override
  Future<int> executeWithParams({AppModel? params}) async {
    calls.add(params);
    if (exception != null) throw exception!;
    return returnValue;
  }

  void reset() {
    returnValue = 0;
    exception = null;
    exception = null;
    calls.clear();
  }
}

void main() {
  group('OnboardUseCase Tests', () {
    late OnboardUseCase useCase;
    late FakeOnboardRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeOnboardRepository();
      useCase = OnboardUseCase(fakeRepository);
    });

    tearDown(() {
      fakeRepository.reset();
    });

    group('executeWithParams', () {
      const testAppModel = AppModel(
        isCompleteOnboard: true,
        activeUser: 1,
        page: Pages.avatarPage,
      );

      test('should return true when repository returns positive value', () async {
        // Arrange
        fakeRepository.returnValue = 1;

        // Act
        final result = await useCase.executeWithParams(params: testAppModel);

        // Assert
        expect(result, true);
        expect(fakeRepository.calls.length, 1);
        expect(fakeRepository.calls.first, testAppModel);
      });

      test('should return false when repository returns zero', () async {
        // Arrange
        fakeRepository.returnValue = 0;

        // Act
        final result = await useCase.executeWithParams(params: testAppModel);

        // Assert
        expect(result, false);
        expect(fakeRepository.calls.length, 1);
      });

      test('should return false when repository returns negative value', () async {
        // Arrange
        fakeRepository.returnValue = -1;
        // Act
        final result = await useCase.executeWithParams(params: testAppModel);
        // Assert
        expect(result, false);
        expect(fakeRepository.calls.length, 1);
      });

      test('should throw ArgumentError when params is null', () async {
        // Act & Assert
        expect(
          () => useCase.executeWithParams(params: null),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should propagate repository exceptions', () async {
        // Arrange
        final exception = Exception('Repository error');
        fakeRepository.exception = exception;

        // Act & Assert
        expect(
          () => useCase.executeWithParams(params: testAppModel),
          throwsA(exception),
        );
        expect(fakeRepository.calls.length, 1);
      });
    });

    group('convertBoolResult extension', () {
      test('should convert positive integers to true', () {
        expect(1.convertBoolResult, true);
        expect(999.convertBoolResult, true);
      });

      test('should convert zero and negative to false', () {
        expect(0.convertBoolResult, false);
        expect((-1).convertBoolResult, false);
      });
    });

    test('should implement UseCase interface', () {
      expect(useCase, isA<UseCase<bool, AppModel>>());
    });
  });
}
