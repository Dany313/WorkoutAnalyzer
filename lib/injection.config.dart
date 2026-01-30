// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'database.dart' as _i969;
import 'features/plan/data/datasources/plan_local_datasource.dart' as _i862;
import 'features/plan/data/repository/plan_repository_impl.dart' as _i911;
import 'features/plan/domain/repository/plan_repository.dart' as _i2;
import 'features/plan/domain/usecases/add_plan_usecase.dart' as _i367;
import 'features/plan/domain/usecases/delete_plan_usecase.dart' as _i543;
import 'features/plan/domain/usecases/get_plans_usecase.dart' as _i854;
import 'features/plan/domain/usecases/update_plan_usecase.dart' as _i456;
import 'injection_module.dart' as _i212;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final databaseModule = _$DatabaseModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i969.AppDatabase>(() => databaseModule.appDatabase);
    gh.lazySingleton<_i862.PlanDataSource>(
      () => _i862.PlanLocalDataSourceImpl(gh<_i969.AppDatabase>()),
    );
    gh.lazySingleton<_i2.PlanRepository>(
      () => _i911.PlanRepositoryImpl(gh<_i862.PlanDataSource>()),
    );
    gh.lazySingleton<_i367.AddPlanUseCase>(
      () => _i367.AddPlanUseCase(gh<_i2.PlanRepository>()),
    );
    gh.lazySingleton<_i456.UpdatePlanUseCase>(
      () => _i456.UpdatePlanUseCase(gh<_i2.PlanRepository>()),
    );
    gh.lazySingleton<_i543.DeletePlanUseCase>(
      () => _i543.DeletePlanUseCase(gh<_i2.PlanRepository>()),
    );
    gh.lazySingleton<_i854.GetPlansUseCase>(
      () => _i854.GetPlansUseCase(gh<_i2.PlanRepository>()),
    );
    return this;
  }
}

class _$DioModule extends _i212.DioModule {}

class _$DatabaseModule extends _i212.DatabaseModule {}
