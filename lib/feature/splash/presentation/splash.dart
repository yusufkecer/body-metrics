import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache_columns.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/entities/params_entity.dart';
import 'package:bodymetrics/feature/splash/domain/use_case/splash_app_use_case.dart';
import 'package:bodymetrics/feature/splash/domain/use_case/splash_user_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

part 'splash_model.dart';

@RoutePage(name: 'SplashView')
@immutable
final class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with DialogUtil, _SplashModel {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
