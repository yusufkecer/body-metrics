import 'package:auto_route/auto_route.dart';
import 'package:bmicalculator/feature/gender/gender.dart';
import 'package:bmicalculator/feature/height/height.dart';
import 'package:bmicalculator/feature/profile_image_picker/profile_image_picker.dart';
import 'package:bmicalculator/feature/user_info_form/user_info_form.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@lazySingleton
@AutoRouterConfig()
final class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: GenderView.page, initial: true),
        AutoRoute(page: HeightView.page),
        AutoRoute(page: ProfileImagePickerView.page),
        AutoRoute(page: UserInfoFormView.page),
      ];
}
