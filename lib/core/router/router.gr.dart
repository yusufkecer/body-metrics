// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    GenderPage.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Gender(),
      );
    }
  };
}

/// generated route for
/// [Gender]
class GenderPage extends PageRouteInfo<void> {
  const GenderPage({List<PageRouteInfo>? children})
      : super(
          GenderPage.name,
          initialChildren: children,
        );

  static const String name = 'GenderPage';

  static const PageInfo<void> page = PageInfo<void>(name);
}
