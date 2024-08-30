import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:injectable/injectable.dart';

@injectable
final class OnboardRepository implements BaseUseCase<bool, AppModel> {
  final userCache = Locator.sl<AppCache>();

  @override
  Future<bool>? execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool>? executeWithParams(AppModel params) async {
    final db = await userCache.initializeDatabase();
    final isComplete = (params.isCompleteOnboard ?? false) ? 1 : 0;

    final data = {
      AppTable.isCompletedOnboard.value: isComplete,
    };

    return userCache.insert(db, data);
  }
}
