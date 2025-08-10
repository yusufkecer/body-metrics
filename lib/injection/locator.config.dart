// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bodymetrics/core/init/language/app_localization.dart' as _i782;
import 'package:bodymetrics/core/router/app_router.dart' as _i1072;
import 'package:bodymetrics/core/theme/custom_theme.dart' as _i906;
import 'package:bodymetrics/data/cache/app_cache/app_cache.dart' as _i458;
import 'package:bodymetrics/data/cache/bmi_cache/user_metrics_cache.dart'
    as _i1049;
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart' as _i981;
import 'package:bodymetrics/data/db/imp_cache.dart' as _i46;
import 'package:bodymetrics/data/index.dart' as _i101;
import 'package:bodymetrics/domain/index.dart' as _i34;
import 'package:bodymetrics/domain/repository/app_repository.dart' as _i82;
import 'package:bodymetrics/domain/use_case/app_use_case.dart' as _i8;
import 'package:bodymetrics/feature/avatar_picker/domain/repository/save_avatar_repository.dart'
    as _i388;
import 'package:bodymetrics/feature/avatar_picker/domain/use_case/save_avatar_use_case.dart'
    as _i406;
import 'package:bodymetrics/feature/gender/domain/repository/save_gender_repository.dart'
    as _i218;
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart'
    as _i708;
import 'package:bodymetrics/feature/gender/presentation/cubit/change_gender_cubit/change_gender.dart'
    as _i778;
import 'package:bodymetrics/feature/height/presentation/height_picker.dart'
    as _i617;
import 'package:bodymetrics/feature/home/domain/repository/user_repository.dart'
    as _i414;
import 'package:bodymetrics/feature/home/domain/use_case/user_use_case.dart'
    as _i815;
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit.dart'
    as _i1014;
import 'package:bodymetrics/feature/index.dart' as _i501;
import 'package:bodymetrics/feature/onboard/domain/repository/onboard_repository.dart'
    as _i85;
import 'package:bodymetrics/feature/onboard/domain/use_case/onboard_use_case.dart'
    as _i293;
import 'package:bodymetrics/feature/onboard/presentation/cubit/onboard_cubit.dart'
    as _i578;
import 'package:bodymetrics/feature/splash/domain/index.dart' as _i29;
import 'package:bodymetrics/feature/splash/domain/repository/splash_repository.dart'
    as _i601;
import 'package:bodymetrics/feature/splash/domain/use_case/splash_use_case.dart'
    as _i165;
import 'package:bodymetrics/feature/splash/presentation/splash.dart' as _i71;
import 'package:bodymetrics/feature/user_general_info/cubit/user_general_info_state.dart'
    as _i1018;
import 'package:bodymetrics/feature/user_general_info/domain/repository/create_profile_repository.dart'
    as _i1073;
import 'package:bodymetrics/feature/user_general_info/domain/use_case/create_profile_use_case.dart'
    as _i470;
import 'package:bodymetrics/feature/weight_picker/domain/repository/save_weight_repository.dart'
    as _i406;
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart'
    as _i986;
import 'package:bodymetrics/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart'
    as _i978;
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
    gh.factory<_i617.HeightSelectorCubit>(() => _i617.HeightSelectorCubit());
    gh.factory<_i1018.UserInfoFormCubit>(() => _i1018.UserInfoFormCubit());
    gh.lazySingleton<_i1072.AppRouter>(() => _i1072.AppRouter());
    gh.lazySingleton<_i906.CustomTheme>(() => _i906.CustomTheme());
    gh.lazySingleton<_i458.AppCache>(() => _i458.AppCache());
    gh.lazySingleton<_i1049.UserMetricsCache>(() => _i1049.UserMetricsCache());
    gh.lazySingleton<_i981.UserCache>(() => _i981.UserCache());
    gh.lazySingleton<_i46.ImpCache>(() => _i46.ImpCache());
    gh.factory<_i406.SaveWeightRepository>(
        () => _i406.SaveWeightRepository(gh<_i101.UserMetricsCache>()));
    gh.lazySingleton<_i782.AppLocalization>(() => _i782.AppLocalization(
          child: gh<_i409.Widget>(),
          key: gh<_i409.Key>(),
        ));
    gh.factory<_i218.SaveGenderRepository>(
        () => _i218.SaveGenderRepository(gh<_i101.UserCache>()));
    gh.factory<_i414.UserRepository>(
        () => _i414.UserRepository(gh<_i981.UserCache>()));
    gh.factory<_i85.OnboardRepository>(
        () => _i85.OnboardRepository(gh<_i101.UserCache>()));
    gh.factory<_i1073.CreateProfileRepository>(
        () => _i1073.CreateProfileRepository(gh<_i981.UserCache>()));
    gh.factory<_i601.SplashRepository>(() => _i601.SplashRepository(
          gh<_i101.AppCache>(),
          gh<_i101.UserCache>(),
        ));
    gh.factory<_i470.CreateProfileUseCase>(
        () => _i470.CreateProfileUseCase(gh<_i1073.CreateProfileRepository>()));
    gh.factory<_i986.SaveWeightUseCase>(
        () => _i986.SaveWeightUseCase(gh<_i406.SaveWeightRepository>()));
    gh.factory<_i388.SaveAvatarRepository>(
        () => _i388.SaveAvatarRepository(gh<_i101.UserCache>()));
    gh.factory<_i815.UserUseCase>(
        () => _i815.UserUseCase(gh<_i414.UserRepository>()));
    gh.factory<_i82.AppRepository>(
        () => _i82.AppRepository(gh<_i101.AppCache>()));
    gh.factory<_i8.AppUseCase>(() => _i8.AppUseCase(gh<_i34.AppRepository>()));
    gh.factory<_i978.WeightPickerCubit>(() => _i978.WeightPickerCubit(
          gh<_i815.UserUseCase>(),
          gh<_i986.SaveWeightUseCase>(),
        ));
    gh.factory<_i1014.UserCubit>(
        () => _i1014.UserCubit(gh<_i815.UserUseCase>()));
    gh.factory<_i293.OnboardUseCase>(
        () => _i293.OnboardUseCase(gh<_i501.OnboardRepository>()));
    gh.factory<_i165.SplashUseCase>(
        () => _i165.SplashUseCase(gh<_i29.SplashRepository>()));
    gh.factory<_i708.SaveGenderUseCase>(
        () => _i708.SaveGenderUseCase(gh<_i218.SaveGenderRepository>()));
    gh.factory<_i406.SaveAvatarUseCase>(
        () => _i406.SaveAvatarUseCase(gh<_i388.SaveAvatarRepository>()));
    gh.factory<_i578.OnboardCubit>(
        () => _i578.OnboardCubit(gh<_i501.OnboardUseCase>()));
    gh.factory<_i778.GenderCubit>(
        () => _i778.GenderCubit(gh<_i708.SaveGenderUseCase>()));
    gh.factory<_i71.SplashCubit>(
        () => _i71.SplashCubit(gh<_i29.SplashUseCase>()));
    return this;
  }
}
