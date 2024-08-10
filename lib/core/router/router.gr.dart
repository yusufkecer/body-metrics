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
    GenderView.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Gender(),
      );
    },
    HeightPage.name: (routeData) {
      final args = routeData.argsAs<HeightPageArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: Height(
          isFemale: args.isFemale,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [Gender]
class GenderView extends PageRouteInfo<void> {
  const GenderView({List<PageRouteInfo>? children})
      : super(
          GenderView.name,
          initialChildren: children,
        );

  static const String name = 'GenderView';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Height]
class HeightPage extends PageRouteInfo<HeightPageArgs> {
  HeightPage({
    required bool isFemale,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HeightPage.name,
          args: HeightPageArgs(
            isFemale: isFemale,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HeightPage';

  static const PageInfo<HeightPageArgs> page = PageInfo<HeightPageArgs>(name);
}

class HeightPageArgs {
  const HeightPageArgs({
    required this.isFemale,
    this.key,
  });

  final bool isFemale;

  final Key? key;

  @override
  String toString() {
    return 'HeightPageArgs{isFemale: $isFemale, key: $key}';
  }
}
