import 'package:workout_app/features/training/domain/usecase/add_train_ex_usecase.dart';
import 'package:workout_app/features/training/domain/usecase/update_train_ex_usecase.dart';

import '../../../../core/utils/typedef.dart';
import '../entity/training.dart';

abstract class TrainRepository {
  ResultFuture<void> addTrainEx(AddTrainExParams params);
  ResultFuture<void> deleteTrainExById(String id);
  ResultFuture<void> updateTrainEx(UpdateTrainExParams params);
  ResultFuture<List<TrainingExerciseEntity>> getTrainExList(String workoutId);
  ResultFuture<TrainingExerciseEntity> getTrainExById(String id);
}
