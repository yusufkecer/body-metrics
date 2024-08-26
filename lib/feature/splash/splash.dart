import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

part 'cubit/splash_cubit.dart';
part 'cubit/splash_state.dart';
part 'domain/repository/splash_repository.dart';
part 'domain/use_case/splash_use_case.dart';
part 'splash_model.dart';

@RoutePage(name: 'SplashView')
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<SplashCubit>(),
      child: const _SplashBody(),
    );
  }
}

class _SplashBody extends StatefulWidget {
  const _SplashBody();

  @override
  State<_SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<_SplashBody> with _SplashModel {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        _asyncInitState();
      },
      child: Text("Splash"),
    );

    const SizedBox.shrink();
  }
}
