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
    ProfileImagePickerView.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileImagePicker(),
      );
    },
    UserInfoFormView.name: (routeData) {
      final args = routeData.argsAs<UserInfoFormViewArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserInfoForm(
          image: args.image,
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
/// [ProfileImagePicker]
class ProfileImagePickerView extends PageRouteInfo<void> {
  const ProfileImagePickerView({List<PageRouteInfo>? children})
      : super(
          ProfileImagePickerView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileImagePickerView';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserInfoForm]
class UserInfoFormView extends PageRouteInfo<UserInfoFormViewArgs> {
  UserInfoFormView({
    required String image,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UserInfoFormView.name,
          args: UserInfoFormViewArgs(
            image: image,
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
    required this.image,
    this.key,
  });

  final String image;

  final Key? key;

  @override
  String toString() {
    return 'UserInfoFormViewArgs{image: $image, key: $key}';
  }
}
