import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../entity/exercise_entity.dart';
import '../repository/exercise_repository.dart';

@lazySingleton
class UpdateExerciseUseCase implements UseCaseWithParams<void, UpdateExerciseParams> {
  final ExerciseRepository repository;

  UpdateExerciseUseCase(this.repository);

  @override
  ResultFuture<void> call(UpdateExerciseParams params) async {
    // Validazione
    if (params.name != null && params.name!.isEmpty) {
      return Left(ServerFailure('Il nome non può essere vuoto'));
    }
    if (params.name != null && params.name!.length < 6) {
      return Left(ServerFailure('Il nome deve avere almeno 6 caratteri'));
    }
    if (params.name != null && params.name!.length > 32) {
      return Left(ServerFailure('Il nome non può avere più di 32 caratteri'));
    }

    return await repository.updateExercise(params);
  }
}

class UpdateExerciseParams {
  final String id;
  final String? name;
  final String? description;
  final Map<MuscleGroups, int>? targetMuscles;


  const UpdateExerciseParams({required this.id, this.name, this.description, this.targetMuscles});

  UpdateExerciseParams copyWith({String? id, String? name, String? description, Map<MuscleGroups, int>? targetMuscles}) {
    return UpdateExerciseParams(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetMuscles: targetMuscles ?? this.targetMuscles,
    );
  }
}
