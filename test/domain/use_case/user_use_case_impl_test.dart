import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/entities/params_entity.dart';
import 'package:bodymetrics/domain/entities/user_entity.dart';
import 'package:bodymetrics/domain/use_case/user_use_case_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
import 'user_use_case_impl_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late UserUseCaseImpl userUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userUseCase = UserUseCaseImpl(mockUserRepository);
    AppUtil.currentUserId = null; // Reset
  });

  group('UserUseCaseImpl', () {
    const tUserId = 1;
    const tUser = User(id: tUserId, name: 'Test User');
    final tUserFilters = UserFilters(id: tUserId).toJson();
    // Since ParamsEntity expects joins list or filters map
    // Check ParamsEntity implementation

    test('executeWithParams calls repository with correct params', () async {
      // Arrange
      final params = ParamsEntity(filters: tUserFilters);
      when(
        mockUserRepository.executeWithParams(params: tUserFilters),
      ).thenAnswer((_) async => tUser);

      // Act
      final result = await userUseCase.executeWithParams(params: params);

      // Assert
      expect(result, tUser);
      verify(
        mockUserRepository.executeWithParams(params: tUserFilters),
      ).called(1);
    });

    test('getCurrentUser returns null if currentUserId is null', () async {
      // Arrange
      AppUtil.currentUserId = null;

      // Act
      final result = await userUseCase.getCurrentUser();

      // Assert
      expect(result, null);
      verifyZeroInteractions(mockUserRepository);
    });

    test('getCurrentUser returns user if currentUserId is set', () async {
      // Arrange
      AppUtil.currentUserId = tUserId;
      when(
        mockUserRepository.executeWithParams(params: tUserFilters),
      ).thenAnswer((_) async => tUser);

      // Act
      final result = await userUseCase.getCurrentUser();

      // Assert
      expect(result, tUser);
      verify(
        mockUserRepository.executeWithParams(params: tUserFilters),
      ).called(1);
    });

    test('getCurrentUserWithMetrics returns user with metrics', () async {
      // Arrange
      AppUtil.currentUserId = tUserId;
      when(
        mockUserRepository.getUserWithMetrics(filters: tUserFilters),
      ).thenAnswer((_) async => tUser);

      // Act
      final result = await userUseCase.getCurrentUserWithMetrics();

      // Assert
      expect(result, tUser);
      verify(
        mockUserRepository.getUserWithMetrics(filters: tUserFilters),
      ).called(1);
    });

    test('getUserById calls repository with correct filters', () async {
      // Arrange
      when(
        mockUserRepository.executeWithParams(params: tUserFilters),
      ).thenAnswer((_) async => tUser);

      // Act
      final result = await userUseCase.getUserById(tUserId);

      // Assert
      expect(result, tUser);
      verify(
        mockUserRepository.executeWithParams(params: tUserFilters),
      ).called(1);
    });
  });
}
