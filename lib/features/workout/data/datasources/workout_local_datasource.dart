import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../database.dart';
import '../model/workout_model.dart';
import '../../domain/usecases/update_workout_usecase.dart';

abstract class WorkoutDataSource {
  Future<List<WorkoutModel>> getWorkouts(String planId);
  Future<List<WorkoutModel>> getWorkoutsByPlanId(String planId);
  Future<void> saveWorkout(String name, String planId);
  Future<void> deleteWorkout(String workoutId);
  Future<WorkoutModel> getWorkoutById(String workoutId);
  Future<void> updateWorkout(UpdateWorkoutParams params);
}

@LazySingleton(as: WorkoutDataSource)
class WorkoutLocalDataSourceImpl implements WorkoutDataSource {
  final AppDatabase database;

  WorkoutLocalDataSourceImpl(this.database);

  @override
  Future<void> deleteWorkout(String workoutId) async {
    await (database.delete(database.workout)
      ..where((t) => t.id.equals(int.parse(workoutId)))).go();
    return Future.value();
  }

  @override
  Future<List<WorkoutModel>> getWorkouts(String planId) async {
    final result = (await (database.select(database.workout)
      ..where((t) => t.planId.equals(int.parse(planId)))).get())
        .map((e) => WorkoutModel(id: e.id.toString(), name: e.name, planId: e.planId.toString()))
        .toList();
    return Future.value(result);
  }

  @override
  Future<List<WorkoutModel>> getWorkoutsByPlanId(String planId) async {
    final result = (await (database.select(database.workout)
          ..where((t) => t.planId.equals(int.parse(planId)))).get())
        .map((e) => WorkoutModel(id: e.id.toString(), name: e.name, planId: e.planId.toString()))
        .toList();
    return Future.value(result);
  }

  @override
  Future<void> saveWorkout(String name, String planId) async {
    await database.into(database.workout).insert(
      WorkoutCompanion.insert(name: name, planId: int.parse(planId)),
    );
    return Future.value();
  }

  @override
  Future<WorkoutModel> getWorkoutById(String workoutId) async {
    final result = await (database.select(database.workout)
          ..where((t) => t.id.equals(int.parse(workoutId))))
        .getSingle();
    return WorkoutModel(id: result.id.toString(), name: result.name, planId: result.planId.toString());
  }

  @override
  Future<void> updateWorkout(UpdateWorkoutParams params) {
    return (database.update(database.workout)
      ..where((t) => t.id.equals(int.parse(params.id))))
        .write(WorkoutCompanion(
          name: Value(params.name),
        ));
  }
}
