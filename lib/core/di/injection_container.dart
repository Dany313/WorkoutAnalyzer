import 'package:get_it/get_it.dart';
import '../../core/database/database_helper.dart';
import '../../features/workout/data/repositories/sqlite_workout_repository_impl.dart';
import '../../features/workout/domain/repositories/workout_repository.dart';
import '../../features/workout/presentation/bloc/workout_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Database
  final dbHelper = DatabaseHelper.instance;
  await dbHelper.database; // Ensure database is initialized
  
  sl.registerLazySingleton<DatabaseHelper>(() => dbHelper);

  // Features - Workout
  // Bloc
  sl.registerFactory(() => WorkoutCubit(repository: sl()));

  // Repository
  sl.registerLazySingleton<WorkoutRepository>(
    () => SqliteWorkoutRepositoryImpl(dbHelper: sl()),
  );
}
