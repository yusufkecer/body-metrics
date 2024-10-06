import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class AppUseCase implements BaseUseCase<Pages, bool, AppModel> {
  final AppRepository repository = Locator.sl<AppRepository>();

  @override

  ///Get [AppCache]
  Future<Pages> execute() async {
    final result = await repository.execute();
    if (result.isNullOrEmpty) {
      return Pages.avatarPage;
    }
    return result!.toPages();
  }

  @override

  ///update [AppCache]
  Future<bool?> executeWithParams(AppModel params) async {
    final result = await repository.executeWithParams(params);
    return result?.convertBoolResult;
  }
}
