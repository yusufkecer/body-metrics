part of '../../presentation/onboard.dart';

@injectable
@immutable
final class OnboardRepository implements BaseUseCase<bool, int, AppModel> {
  final userCache = Locator.sl<AppCache>();

  @override
  Future<bool> execute() {
    throw UnimplementedError();
  }

  @override
  Future<int> executeWithParams(AppModel params) async {
    final db = await userCache.initializeDatabase();
    final isComplete = (params.isCompleteOnboard ?? false) ? 1 : 0;

    final data = {
      AppColumns.isCompletedOnboard.value: isComplete,
    };

    return userCache.insert(db, data);
  }
}
