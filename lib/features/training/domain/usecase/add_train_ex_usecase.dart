import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../repository/train_repository.dart';

class AddTrainExUsecase extends UseCaseWithParams<void, AddTrainExParams>{
  final TrainRepository repository;

  AddTrainExUsecase(this.repository);

  @override
  ResultFuture<void> call(AddTrainExParams params) {
    return repository.addTrainEx(params);
  }

}


class AddTrainExParams{
  final String exerciseId;
  final int sets;
  final int reps;
  final int restSeconds;
  final int rpe;

  const AddTrainExParams({required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.rpe
  }
  );

  AddTrainExParams copyWith({
    String? exerciseId,
    int? sets,
    int? reps,
    int? restSeconds,
    int? rpe}
      ) {
    return AddTrainExParams(
        exerciseId: exerciseId ?? this.exerciseId,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        restSeconds: restSeconds ?? this.restSeconds,
        rpe: rpe ?? this.rpe);
  }



}