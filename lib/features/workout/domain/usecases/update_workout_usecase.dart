import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../repository/workout_repository.dart';

@lazySingleton
class UpdateWorkoutUseCase implements UseCaseWithParams<void, UpdateWorkoutParams> {
  final WorkoutRepository repository;

  UpdateWorkoutUseCase(this.repository);

  @override
  ResultFuture<void> call(UpdateWorkoutParams params) async {
    // Validazione
    if (params.name.isEmpty) {
      return Left(ServerFailure('Il nome non può essere vuoto'));
    }
    if (params.name.length < 6) {
      return Left(ServerFailure('Il nome deve avere almeno 6 caratteri'));
    }
    if (params.name.length > 32) {
      return Left(ServerFailure('Il nome non può avere più di 32 caratteri'));
    }

    return await repository.updateWorkout(params);
  }
}

class UpdateWorkoutParams {
  final String id;
  final String name;

  const UpdateWorkoutParams({required this.id, required this.name});

  UpdateWorkoutParams copyWith({String? id, String? name, String? planId}) {
    return UpdateWorkoutParams(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
