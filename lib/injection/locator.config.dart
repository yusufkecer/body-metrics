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
import 'package:bodymetrics/data/cache/user_cache.dart' as _i333;
import 'package:bodymetrics/data/index.dart' as _i101;
import 'package:bodymetrics/domain/index.dart' as _i34;
import 'package:bodymetrics/feature/gender/cubit/gender_select/change_gender.dart'
    as _i42;
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
    gh.factory<_i42.GenderCubit>(() => _i42.GenderCubit());
    gh.lazySingleton<_i125.AppRouter>(() => _i125.AppRouter());
    gh.lazySingleton<_i353.BaseTheme>(() => _i353.BaseTheme());
    gh.factory<_i101.CacheMethods<_i34.Users>>(() => _i333.UserCache());
    gh.factory<_i101.CacheMethods<_i34.Settings>>(() => _i174.AppCache());
    gh.lazySingleton<_i782.ProductLocalization>(() => _i782.ProductLocalization(
          child: gh<_i409.Widget>(),
          key: gh<_i409.Key>(),
        ));
    gh.factory<_i101.CacheMethods<_i34.BMIS>>(() => _i804.BMICache());
    return this;
  }
}
