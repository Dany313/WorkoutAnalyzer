import 'package:workout_app/core/utils/typedef.dart';
import '../entity/exercise_entity.dart';
import '../usecases/add_exercise_usecase.dart';
import '../usecases/update_exercise_usecase.dart';

abstract class ExerciseRepository {
  ResultFuture<void> addExercise(AddExerciseParams params);
  ResultFuture<List<ExerciseEntity>> getExercisesList();
  ResultFuture<ExerciseEntity> getExerciseById(String id);
  ResultFuture<void> deleteExerciseById(String id);
  ResultFuture<void> updateExercise(UpdateExerciseParams params);
}
