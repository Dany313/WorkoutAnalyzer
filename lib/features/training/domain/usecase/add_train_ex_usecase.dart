import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../repository/train_repository.dart';

@lazySingleton
class AddTrainExUsecase extends UseCaseWithParams<void, AddTrainExParams>{
  final TrainRepository repository;

  AddTrainExUsecase(this.repository);

  @override
  ResultFuture<void> call(AddTrainExParams params) {
    return repository.addTrainEx(params);
  }

}


class AddTrainExParams{
  final String workoutId;
  final String exerciseId;
  final int sets;
  final int reps;
  final int restSeconds;
  final int rpe;

  const AddTrainExParams({
    required this.workoutId,
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.rpe
  }
  );

  AddTrainExParams copyWith({
    String? workoutId,
    String? exerciseId,
    int? sets,
    int? reps,
    int? restSeconds,
    int? rpe}
      ) {
    return AddTrainExParams(
        workoutId: workoutId ?? this.workoutId,
        exerciseId: exerciseId ?? this.exerciseId,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        restSeconds: restSeconds ?? this.restSeconds,
        rpe: rpe ?? this.rpe);
  }



}
