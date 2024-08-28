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
    AvatarPickerView.name: (routeData) {
      final args = routeData.argsAs<AvatarPickerViewArgs>(
          orElse: () => const AvatarPickerViewArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AvatarPicker(
          key: args.key,
          canSkip: args.canSkip,
        ),
      );
    },
    GenderView.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Gender(),
      );
    },
    HeightView.name: (routeData) {
      final args = routeData.argsAs<HeightViewArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: Height(
          isFemale: args.isFemale,
          key: args.key,
        ),
      );
    },
    OnboardView.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Onboard(),
      );
    },
    SplashView.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Splash(),
      );
    },
    UserInfoFormView.name: (routeData) {
      final args = routeData.argsAs<UserInfoFormViewArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserInfoForm(
          avatar: args.avatar,
          key: args.key,
        ),
      );
    },
    WeightView.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WeightPicker(),
      );
    },
  };
}

/// generated route for
/// [AvatarPicker]
class AvatarPickerView extends PageRouteInfo<AvatarPickerViewArgs> {
  AvatarPickerView({
    Key? key,
    bool canSkip = true,
    List<PageRouteInfo>? children,
  }) : super(
          AvatarPickerView.name,
          args: AvatarPickerViewArgs(
            key: key,
            canSkip: canSkip,
          ),
          initialChildren: children,
        );

  static const String name = 'AvatarPickerView';

  static const PageInfo<AvatarPickerViewArgs> page =
      PageInfo<AvatarPickerViewArgs>(name);
}

class AvatarPickerViewArgs {
  const AvatarPickerViewArgs({
    this.key,
    this.canSkip = true,
  });

  final Key? key;

  final bool canSkip;

  @override
  String toString() {
    return 'AvatarPickerViewArgs{key: $key, canSkip: $canSkip}';
  }
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
class HeightView extends PageRouteInfo<HeightViewArgs> {
  HeightView({
    required bool isFemale,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HeightView.name,
          args: HeightViewArgs(
            isFemale: isFemale,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HeightView';

  static const PageInfo<HeightViewArgs> page = PageInfo<HeightViewArgs>(name);
}

class HeightViewArgs {
  const HeightViewArgs({
    required this.isFemale,
    this.key,
  });

  final bool isFemale;

  final Key? key;

  @override
  String toString() {
    return 'HeightViewArgs{isFemale: $isFemale, key: $key}';
  }
}

/// generated route for
/// [Onboard]
class OnboardView extends PageRouteInfo<void> {
  const OnboardView({List<PageRouteInfo>? children})
      : super(
          OnboardView.name,
          initialChildren: children,
        );

  static const String name = 'OnboardView';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Splash]
class SplashView extends PageRouteInfo<void> {
  const SplashView({List<PageRouteInfo>? children})
      : super(
          SplashView.name,
          initialChildren: children,
        );

  static const String name = 'SplashView';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserInfoForm]
class UserInfoFormView extends PageRouteInfo<UserInfoFormViewArgs> {
  UserInfoFormView({
    required String avatar,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UserInfoFormView.name,
          args: UserInfoFormViewArgs(
            avatar: avatar,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserInfoFormView';

  static const PageInfo<UserInfoFormViewArgs> page =
      PageInfo<UserInfoFormViewArgs>(name);
}

class UserInfoFormViewArgs {
  const UserInfoFormViewArgs({
    required this.avatar,
    this.key,
  });

  final String avatar;

  final Key? key;

  @override
  String toString() {
    return 'UserInfoFormViewArgs{avatar: $avatar, key: $key}';
  }
}

/// generated route for
/// [WeightPicker]
class WeightView extends PageRouteInfo<void> {
  const WeightView({List<PageRouteInfo>? children})
      : super(
          WeightView.name,
          initialChildren: children,
        );

  static const String name = 'WeightView';

  static const PageInfo<void> page = PageInfo<void>(name);
}
