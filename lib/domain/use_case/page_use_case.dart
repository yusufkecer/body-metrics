import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class PageUseCase implements BaseUseCase<Pages, bool, Json> {
  final PageRepository repository = Locator.sl<PageRepository>();

  @override

  ///Get the current page to the [AppCache]
  Future<Pages> execute() async {
    final result = await repository.execute();
    if (result.isNullOrEmpty) {
      return Pages.avatarPage;
    }
    return result!.toPages();
  }

  @override

  ///Set the current page to the [AppCache]
  Future<bool?> executeWithParams(Json params) async {
    final result = await repository.executeWithParams(params);
    return result?.convertBoolResult;
  }
}
