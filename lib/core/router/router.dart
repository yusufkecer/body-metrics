import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:myapp/feature/gender/gender.dart';
part 'router.gr.dart';

@lazySingleton
@AutoRouterConfig()
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: GenderPage.page, initial: true),
      ];
}
