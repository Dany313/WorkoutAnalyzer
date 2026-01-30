import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/database.dart';


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
