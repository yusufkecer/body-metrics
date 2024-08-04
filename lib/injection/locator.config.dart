// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bmicalculator/core/cache/bmi_cache.dart' as _i893;
import 'package:bmicalculator/core/cache/user_cache.dart' as _i796;
import 'package:bmicalculator/core/router/router.dart' as _i454;
import 'package:bmicalculator/core/util/theme/base_theme.dart' as _i46;
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
    gh.factory<_i893.BMICache>(() => _i893.BMICache());
    gh.factory<_i796.UserCache>(() => _i796.UserCache());
    gh.lazySingleton<_i454.AppRouter>(() => _i454.AppRouter());
    gh.lazySingleton<_i46.BaseTheme>(() => _i46.BaseTheme());
    return this;
  }
}
