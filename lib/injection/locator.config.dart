// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bodymetrics/core/init/language/app_localization.dart' as _i782;
import 'package:bodymetrics/core/router/router.dart' as _i125;
import 'package:bodymetrics/core/util/theme/base_theme.dart' as _i353;
import 'package:bodymetrics/data/cache/app_cache.dart' as _i174;
import 'package:bodymetrics/data/cache/bmi_cache.dart' as _i804;
import 'package:bodymetrics/data/cache/imp_cache.dart' as _i956;
import 'package:bodymetrics/data/cache/user_cache.dart' as _i333;
import 'package:bodymetrics/feature/create_profile/create_profile.dart'
    as _i244;
import 'package:bodymetrics/feature/gender/cubit/gender_select/change_gender.dart'
    as _i42;
import 'package:bodymetrics/feature/height_picker/height_picker.dart' as _i664;
import 'package:bodymetrics/feature/onboard/cubit/onboard_cubit.dart' as _i40;
import 'package:bodymetrics/feature/splash/splash.dart' as _i463;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i174.AppCache>(() => _i174.AppCache());
    gh.factory<_i804.BMICache>(() => _i804.BMICache());
    gh.factory<_i956.ImpCache>(() => _i956.ImpCache());
    gh.factory<_i333.UserCache>(() => _i333.UserCache());
    gh.factory<_i244.CreateProfileRepository>(
        () => _i244.CreateProfileRepository());
    gh.factory<_i42.GenderCubit>(() => _i42.GenderCubit());
    gh.factory<_i664.HeightSelectorCubit>(() => _i664.HeightSelectorCubit());
    gh.factory<_i463.SplashCubit>(() => _i463.SplashCubit());
    gh.factory<_i463.SplashRepository>(() => _i463.SplashRepository());
    gh.factory<_i463.SplashUseCase>(() => _i463.SplashUseCase());
    gh.factory<_i40.OnboardCubit>(() => _i40.OnboardCubit());
    gh.lazySingleton<_i125.AppRouter>(() => _i125.AppRouter());
    gh.lazySingleton<_i353.BaseTheme>(() => _i353.BaseTheme());
    gh.lazySingleton<_i782.ProductLocalization>(() => _i782.ProductLocalization(
          child: gh<_i409.Widget>(),
          key: gh<_i409.Key>(),
        ));
    gh.factory<_i244.CreateProfileUseCase>(
        () => _i244.CreateProfileUseCase(gh<_i244.CreateProfileRepository>()));
    return this;
  }
}
