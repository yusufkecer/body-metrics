import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashView.page, initial: true),
        AutoRoute(page: OnboardView.page),
        AutoRoute(page: AvatarPickerView.page),
        AutoRoute(page: UserGeneralInfoView.page),
        AutoRoute(page: GenderView.page),
        AutoRoute(page: HeightView.page),
        AutoRoute(page: WeightView.page),
        AutoRoute(page: UserOperationsView.page),
        AutoRoute(page: HomeView.page),
      ];
}
