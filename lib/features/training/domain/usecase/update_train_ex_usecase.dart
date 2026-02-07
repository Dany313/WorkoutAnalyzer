import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../repository/train_repository.dart';

@lazySingleton
class UpdateTrainExUsecase extends UseCaseWithParams<void, UpdateTrainExParams>{
  final TrainRepository repository;

  UpdateTrainExUsecase(this.repository);

  @override
  ResultFuture<void> call(UpdateTrainExParams params) {
    return repository.updateTrainEx(params);
  }
}


class UpdateTrainExParams {
  final String id;
  final String exerciseId;
  final int sets;
  final int reps;
  final int restSeconds;
  final int rpe;

  const UpdateTrainExParams({
    required this.id,
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.rpe,
  });

  UpdateTrainExParams copyWith({
    String? id,
    String? exerciseId,
    int? sets,
    int? reps,
    int? restSeconds,
    int? rpe,
  }) {
    return UpdateTrainExParams(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      rpe: rpe ?? this.rpe,
    );
  }
}
