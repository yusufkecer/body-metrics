import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';

mixin SaveAppMixin {
  Future<bool?> saveApp(Pages page) async {
    final pageUseCase = Locator.sl<AppUseCase>();
    final appModel = AppModel(page: page);
    final result = await pageUseCase.executeWithParams(appModel);

    return result;
  }
}
