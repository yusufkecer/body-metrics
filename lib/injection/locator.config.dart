// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bodymetrics/core/init/language/app_localization.dart' as _i782;
import 'package:bodymetrics/core/router/app_router.dart' as _i1072;
import 'package:bodymetrics/core/theme/custom_theme.dart' as _i353;
import 'package:bodymetrics/data/cache/app_cache/app_cache.dart' as _i458;
import 'package:bodymetrics/data/cache/bmi_cache/bmi_cache.dart' as _i226;
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart' as _i981;
import 'package:bodymetrics/data/db/imp_cache.dart' as _i46;
import 'package:bodymetrics/feature/create_profile/presentation/create_profile.dart' as _i663;
import 'package:bodymetrics/feature/gender/presentation/cubit/change_gender.dart' as _i348;
import 'package:bodymetrics/feature/height_picker/presentation/height_picker.dart' as _i306;
import 'package:bodymetrics/feature/onboard/domain/repository/onboard_repository.dart' as _i85;
import 'package:bodymetrics/feature/onboard/domain/use_case/onboard_use_case.dart' as _i293;
import 'package:bodymetrics/feature/onboard/presentation/onboard.dart' as _i566;
import 'package:bodymetrics/feature/splash/presentation/splash.dart' as _i71;
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
    gh.factory<_i458.AppCache>(() => _i458.AppCache());
    gh.factory<_i663.CreateProfileRepository>(() => _i663.CreateProfileRepository());
    gh.factory<_i348.GenderCubit>(() => _i348.GenderCubit());
    gh.factory<_i306.HeightSelectorCubit>(() => _i306.HeightSelectorCubit());
    gh.factory<_i85.OnboardRepository>(() => _i85.OnboardRepository());
    gh.factory<_i293.OnboardUseCase>(() => _i293.OnboardUseCase());
    gh.factory<_i566.OnboardCubit>(() => _i566.OnboardCubit());
    gh.factory<_i71.SplashCubit>(() => _i71.SplashCubit());
    gh.factory<_i71.SplashRepository>(() => _i71.SplashRepository());
    gh.factory<_i71.SplashUseCase>(() => _i71.SplashUseCase());
    gh.factory<_i226.BmiCache>(() => _i226.BmiCache());
    gh.factory<_i981.UserCache>(() => _i981.UserCache());
    gh.factory<_i46.ImpCache>(() => _i46.ImpCache());
    gh.lazySingleton<_i353.CustomTheme>(() => _i353.CustomTheme());
    gh.lazySingleton<_i1072.AppRouter>(() => _i1072.AppRouter());
    gh.lazySingleton<_i782.AppLocalization>(() => _i782.AppLocalization(
          child: gh<_i409.Widget>(),
          key: gh<_i409.Key>(),
        ));
    gh.factory<_i663.CreateProfileUseCase>(() => _i663.CreateProfileUseCase(gh<_i663.CreateProfileRepository>()));
    return this;
  }
}
