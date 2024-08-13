// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bmicalculator/core/init/language/app_localization.dart'
    as _i162;
import 'package:bmicalculator/core/router/router.dart' as _i454;
import 'package:bmicalculator/core/util/theme/base_theme.dart' as _i46;
import 'package:bmicalculator/data/cache/app_cache.dart' as _i138;
import 'package:bmicalculator/data/cache/bmi_cache.dart' as _i682;
import 'package:bmicalculator/data/cache/user_cache.dart' as _i575;
import 'package:bmicalculator/data/index.dart' as _i427;
import 'package:bmicalculator/domain/index.dart' as _i906;
import 'package:bmicalculator/feature/gender/cubit/gender_select/change_gender.dart'
    as _i907;
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
    gh.factory<_i907.GenderCubit>(() => _i907.GenderCubit());
    gh.lazySingleton<_i454.AppRouter>(() => _i454.AppRouter());
    gh.lazySingleton<_i46.BaseTheme>(() => _i46.BaseTheme());
    gh.factory<_i427.CacheMethods<_i906.BMIS>>(() => _i682.BMICache());
    gh.lazySingleton<_i162.ProductLocalization>(() => _i162.ProductLocalization(
          child: gh<_i409.Widget>(),
          key: gh<_i409.Key>(),
        ));
    gh.factory<_i427.CacheMethods<_i906.Users>>(() => _i575.UserCache());
    gh.factory<_i427.CacheMethods<_i906.Settings>>(() => _i138.AppCache());
    return this;
  }
}
