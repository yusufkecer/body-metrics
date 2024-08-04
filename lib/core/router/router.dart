import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/feature/gender/gender.dart';

import 'package:injectable/injectable.dart';
part 'router.gr.dart';

@lazySingleton
@AutoRouterConfig()
final class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: GenderPage.page, initial: true),
      ];
}
