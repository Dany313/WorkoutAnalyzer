import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../entity/training.dart';
import '../repository/train_repository.dart';

class GetTrainExByIdUsecase
    extends UseCaseWithParams<TrainingExerciseEntity, String> {
  final TrainRepository repository;

  GetTrainExByIdUsecase(this.repository);

  @override
  ResultFuture<TrainingExerciseEntity> call(String params) {
    return repository.getTrainExById(params);
  }
}
