import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';

mixin SavePageMixin {
  Future<bool?> setPage(Pages page) async {
    final pageUseCase = Locator.sl<PageUseCase>();
    final appModel = AppModel(page: page);
    final result = await pageUseCase.executeWithParams(appModel);

    'setPage: $result'.log;
    return result;
  }
}
