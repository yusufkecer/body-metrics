import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:bodymetrics/product/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class PageUseCase implements BaseUseCase<Pages, Json> {
  final PageRepository repository = Locator.sl<PageRepository>();
  @override
  Future<Pages> execute() async {
    final result = await repository.execute();
    if (result.isNullOrEmpty) {
      return Pages.avatarPage;
    }
    return result!.toPages();
  }

  @override
  Future<Pages> executeWithParams(Json params) async {
    throw UnimplementedError();
  }
}
