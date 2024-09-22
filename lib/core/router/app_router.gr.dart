// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AvatarPickerViewArgs>(
          orElse: () => const AvatarPickerViewArgs());
      return AvatarPicker(
        key: args.key,
        canSkip: args.canSkip,
      );
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Gender();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HeightViewArgs>();
      return Height(
        isFemale: args.isFemale,
        key: args.key,
      );
    },
  );
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
/// [Home]
class HomeView extends PageRouteInfo<void> {
  const HomeView({List<PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Home();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Onboard();
    },
  );
}

/// generated route for
/// [ResultList]
class ResultListView extends PageRouteInfo<ResultListViewArgs> {
  ResultListView({
    Key? key,
    UserMetrics? userMetrics,
    List<PageRouteInfo>? children,
  }) : super(
          ResultListView.name,
          args: ResultListViewArgs(
            key: key,
            userMetrics: userMetrics,
          ),
          initialChildren: children,
        );

  static const String name = 'ResultListView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResultListViewArgs>(
          orElse: () => const ResultListViewArgs());
      return ResultList(
        key: args.key,
        userMetrics: args.userMetrics,
      );
    },
  );
}

class ResultListViewArgs {
  const ResultListViewArgs({
    this.key,
    this.userMetrics,
  });

  final Key? key;

  final UserMetrics? userMetrics;

  @override
  String toString() {
    return 'ResultListViewArgs{key: $key, userMetrics: $userMetrics}';
  }
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Splash();
    },
  );
}

/// generated route for
/// [UserGeneralInfo]
class UserGeneralInfoView extends PageRouteInfo<UserGeneralInfoViewArgs> {
  UserGeneralInfoView({
    required String avatar,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UserGeneralInfoView.name,
          args: UserGeneralInfoViewArgs(
            avatar: avatar,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UserGeneralInfoView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserGeneralInfoViewArgs>();
      return UserGeneralInfo(
        avatar: args.avatar,
        key: args.key,
      );
    },
  );
}

class UserGeneralInfoViewArgs {
  const UserGeneralInfoViewArgs({
    required this.avatar,
    this.key,
  });

  final String avatar;

  final Key? key;

  @override
  String toString() {
    return 'UserGeneralInfoViewArgs{avatar: $avatar, key: $key}';
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WeightPicker();
    },
  );
}
