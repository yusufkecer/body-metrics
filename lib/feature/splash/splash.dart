import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'cubit/splash_cubit.dart';
part 'cubit/splash_state.dart';
part 'domain/repository/splash_repository.dart';
part 'domain/use_case/splash_use_case.dart';
part 'splash_model.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with _SplashModel {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
