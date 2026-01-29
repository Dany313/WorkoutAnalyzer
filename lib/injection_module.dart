import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/features/plan/domain/repository/plan_repository.dart';
import 'package:workout_app/database.dart';

import 'features/plan/data/repository/plan_repository_impl.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio();
}

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();
}

// @module
// abstract class RepositoryModule {
//   @lazySingleton
//   PlanRepository workoutRepository(PlanRepositoryImpl impl) => impl;
// }
