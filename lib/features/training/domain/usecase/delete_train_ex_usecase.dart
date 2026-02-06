import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../repository/train_repository.dart';

class DeleteTrainExUsecase extends UseCaseWithParams<void, String>{
  final TrainRepository repository;

  DeleteTrainExUsecase(this.repository);

  @override
  ResultFuture<void> call(String id) {
    return repository.deleteTrainExById(id);
  }
}
