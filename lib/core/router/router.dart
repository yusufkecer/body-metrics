import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/feature/gender/gender.dart';
import 'package:bodymetrics/feature/height/height.dart';
import 'package:bodymetrics/feature/user_info_form/user_info_form.dart';
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
        AutoRoute(page: AvatarPickerView.page),
        AutoRoute(page: UserInfoFormView.page),
      ];
}
