import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../entity/training.dart';
import '../repository/train_repository.dart';

class GetTrainExListUsecase
    extends UseCaseWithParams<List<TrainingExerciseEntity>, String> {
  final TrainRepository repository;

  GetTrainExListUsecase(this.repository);

  @override
  ResultFuture<List<TrainingExerciseEntity>> call(String workoutId) {
    return repository.getTrainExList(workoutId);
  }
}
