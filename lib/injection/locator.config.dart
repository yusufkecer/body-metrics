// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bodymetrics/core/router/app_router.dart' as _i1072;
import 'package:bodymetrics/core/theme/custom_theme.dart' as _i906;
import 'package:bodymetrics/data/cache/app_cache/app_cache.dart' as _i458;
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart' as _i981;
import 'package:bodymetrics/data/cache/user_metrics_cache/user_metrics_cache.dart'
    as _i35;
import 'package:bodymetrics/data/db/imp_cache.dart' as _i46;
import 'package:bodymetrics/data/index.dart' as _i101;
import 'package:bodymetrics/domain/index.dart' as _i34;
import 'package:bodymetrics/domain/repository/app_info_repository.dart'
    as _i728;
import 'package:bodymetrics/domain/repository/save_app_repository.dart'
    as _i395;
import 'package:bodymetrics/domain/repository/user_repository_impl.dart'
    as _i302;
import 'package:bodymetrics/domain/use_case/app_info_use_case.dart' as _i792;
import 'package:bodymetrics/domain/use_case/save_app_use_case.dart' as _i78;
import 'package:bodymetrics/domain/use_case/set_id_use_case.dart' as _i830;
import 'package:bodymetrics/domain/use_case/user_use_case_impl.dart' as _i958;
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
import 'package:bodymetrics/feature/height/domain/repository/save_height_repository.dart'
    as _i896;
import 'package:bodymetrics/feature/height/domain/use_case/save_height_use_case.dart'
    as _i681;
import 'package:bodymetrics/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit.dart'
    as _i612;
import 'package:bodymetrics/feature/height/presentation/cubit/save_height_cubit/save_height_cubit.dart'
    as _i536;
import 'package:bodymetrics/feature/home/domain/repository/user_metric_repository.dart'
    as _i674;
import 'package:bodymetrics/feature/home/domain/use_case/user_metric_use_case.dart'
    as _i799;
import 'package:bodymetrics/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart'
    as _i319;
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit/user_cubit.dart'
    as _i954;
import 'package:bodymetrics/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart'
    as _i906;
import 'package:bodymetrics/feature/index.dart' as _i501;
import 'package:bodymetrics/feature/onboard/domain/repository/onboard_repository.dart'
    as _i85;
import 'package:bodymetrics/feature/onboard/domain/use_case/onboard_use_case.dart'
    as _i293;
import 'package:bodymetrics/feature/onboard/presentation/cubit/onboard_cubit.dart'
    as _i578;
import 'package:bodymetrics/feature/splash/domain/repository/splash_app_repository.dart'
    as _i437;
import 'package:bodymetrics/feature/splash/domain/repository/splash_user_repository.dart'
    as _i288;
import 'package:bodymetrics/feature/splash/domain/use_case/splash_app_use_case.dart'
    as _i31;
import 'package:bodymetrics/feature/splash/domain/use_case/splash_user_use_case.dart'
    as _i193;
import 'package:bodymetrics/feature/user_general_info/cubit/user_info_form_cubit.dart'
    as _i226;
import 'package:bodymetrics/feature/user_general_info/domain/index.dart'
    as _i171;
import 'package:bodymetrics/feature/user_general_info/domain/repository/create_profile_repository.dart'
    as _i1073;
import 'package:bodymetrics/feature/user_general_info/domain/use_case/create_profile_use_case.dart'
    as _i470;
import 'package:bodymetrics/feature/weight_picker/domain/repository/save_weight_repository.dart'
    as _i406;
import 'package:bodymetrics/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart'
    as _i938;
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart'
    as _i986;
import 'package:bodymetrics/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart'
    as _i978;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i830.SetIdUseCase>(() => const _i830.SetIdUseCase());
    gh.factory<_i612.HeightSelectorCubit>(() => _i612.HeightSelectorCubit());
    gh.factory<_i319.HomeCardCubit>(() => _i319.HomeCardCubit());
    gh.factory<_i938.CalculateBmiUseCase>(
      () => const _i938.CalculateBmiUseCase(),
    );
    gh.lazySingleton<_i1072.AppRouter>(() => _i1072.AppRouter());
    gh.lazySingleton<_i906.CustomTheme>(() => _i906.CustomTheme());
    gh.lazySingleton<_i458.AppCache>(() => _i458.AppCache());
    gh.lazySingleton<_i981.UserCache>(() => _i981.UserCache());
    gh.lazySingleton<_i35.UserMetricsCache>(() => _i35.UserMetricsCache());
    gh.lazySingleton<_i46.ImpCache>(() => _i46.ImpCache());
    gh.factory<_i728.AppInfoRepository>(
      () => _i728.AppInfoRepository(gh<_i101.AppCache>()),
    );
    gh.factory<_i395.SaveAppRepository>(
      () => _i395.SaveAppRepository(gh<_i101.AppCache>()),
    );
    gh.factory<_i85.OnboardRepository>(
      () => _i85.OnboardRepository(gh<_i101.AppCache>()),
    );
    gh.factory<_i674.UserMetricRepository>(
      () => _i674.UserMetricRepository(gh<_i101.UserMetricsCache>()),
    );
    gh.factory<_i406.SaveWeightRepository>(
      () => _i406.SaveWeightRepository(gh<_i101.UserMetricsCache>()),
    );
    gh.factory<_i388.SaveAvatarRepository>(
      () => _i388.SaveAvatarRepository(gh<_i101.UserCache>()),
    );
    gh.factory<_i896.SaveHeightRepository>(
      () => _i896.SaveHeightRepository(gh<_i101.UserCache>()),
    );
    gh.factory<_i302.UserRepositoryImpl>(
      () => _i302.UserRepositoryImpl(gh<_i101.UserCache>()),
    );
    gh.factory<_i218.SaveGenderRepository>(
      () => _i218.SaveGenderRepository(gh<_i101.UserCache>()),
    );
    gh.factory<_i288.SplashUserRepository>(
      () => _i288.SplashUserRepository(gh<_i101.UserCache>()),
    );
    gh.factory<_i1073.CreateProfileRepository>(
      () => _i1073.CreateProfileRepository(gh<_i101.UserCache>()),
    );
    gh.factory<_i470.CreateProfileUseCase>(
      () => _i470.CreateProfileUseCase(gh<_i1073.CreateProfileRepository>()),
    );
    gh.factory<_i406.SaveAvatarUseCase>(
      () => _i406.SaveAvatarUseCase(gh<_i388.SaveAvatarRepository>()),
    );
    gh.factory<_i78.SaveAppUseCase>(
      () => _i78.SaveAppUseCase(gh<_i395.SaveAppRepository>()),
    );
    gh.factory<_i986.SaveWeightUseCase>(
      () => _i986.SaveWeightUseCase(gh<_i406.SaveWeightRepository>()),
    );
    gh.factory<_i437.SplashAppRepository>(
      () => _i437.SplashAppRepository(
        gh<_i101.AppCache>(),
        gh<_i101.UserCache>(),
      ),
    );
    gh.factory<_i31.SplashAppUseCase>(
      () => _i31.SplashAppUseCase(gh<_i437.SplashAppRepository>()),
    );
    gh.factory<_i708.SaveGenderUseCase>(
      () => _i708.SaveGenderUseCase(gh<_i218.SaveGenderRepository>()),
    );
    gh.factory<_i226.UserInfoFormCubit>(
      () => _i226.UserInfoFormCubit(gh<_i171.CreateProfileUseCase>()),
    );
    gh.factory<_i799.UserMetricUseCase>(
      () => _i799.UserMetricUseCase(gh<_i674.UserMetricRepository>()),
    );
    gh.factory<_i958.UserUseCaseImpl>(
      () => _i958.UserUseCaseImpl(gh<_i34.UserRepositoryImpl>()),
    );
    gh.factory<_i681.SaveHeightUseCase>(
      () => _i681.SaveHeightUseCase(gh<_i896.SaveHeightRepository>()),
    );
    gh.factory<_i193.SplashUserUseCase>(
      () => _i193.SplashUserUseCase(gh<_i288.SplashUserRepository>()),
    );
    gh.factory<_i792.AppInfoUseCase>(
      () => _i792.AppInfoUseCase(gh<_i34.AppInfoRepository>()),
    );
    gh.factory<_i293.OnboardUseCase>(
      () => _i293.OnboardUseCase(gh<_i85.OnboardRepository>()),
    );
    gh.factory<_i778.GenderCubit>(
      () => _i778.GenderCubit(gh<_i708.SaveGenderUseCase>()),
    );
    gh.factory<_i536.SaveHeightCubit>(
      () => _i536.SaveHeightCubit(gh<_i681.SaveHeightUseCase>()),
    );
    gh.factory<_i578.OnboardCubit>(
      () => _i578.OnboardCubit(gh<_i501.OnboardUseCase>()),
    );
    gh.factory<_i954.UserCubit>(
      () => _i954.UserCubit(gh<_i34.UserUseCaseImpl>()),
    );
    gh.factory<_i906.UserMetricCubit>(
      () => _i906.UserMetricCubit(gh<_i799.UserMetricUseCase>()),
    );
    gh.factory<_i978.WeightPickerCubit>(
      () => _i978.WeightPickerCubit(
        gh<_i34.UserUseCaseImpl>(),
        gh<_i986.SaveWeightUseCase>(),
        gh<_i938.CalculateBmiUseCase>(),
      ),
    );
    return this;
  }
}
