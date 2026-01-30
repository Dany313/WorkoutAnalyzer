import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/features/workout/domain/entity/workout_entity.dart';
import 'package:workout_app/features/workout/domain/usecases/update_workout_usecase.dart';

abstract class WorkoutRepository {
  ResultFuture<void> addWorkout(String name, String planId);
  ResultFuture<List<WorkoutEntity>> getWorkoutsList(String planId);
  ResultFuture<WorkoutEntity> getWorkoutById(String id);
  ResultFuture<void> deleteWorkoutById(String id);
  ResultFuture<void> updateWorkout(UpdateWorkoutParams params);
}
