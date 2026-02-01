import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../entity/exercise_entity.dart';
import '../repository/exercise_repository.dart';

@lazySingleton
class AddExerciseUseCase implements UseCaseWithParams<void, AddExerciseParams> {
  final ExerciseRepository repository;

  AddExerciseUseCase(this.repository);

  @override
  ResultFuture<void> call(AddExerciseParams params) async {
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
    if (params.targetMuscles.isEmpty) {
      return Left(ServerFailure('targetMuscles non può essere vuoto'));
    }

    return await repository.addExercise(params);
  }
}

class AddExerciseParams {
  final String name;
  final String description;
  final Map<MuscleGroups, int> targetMuscles;

  const AddExerciseParams({required this.name, required this.description, required this.targetMuscles});

  AddExerciseParams copyWith({String? name, String? planId}) {
    return AddExerciseParams(name: name ?? this.name, description: description, targetMuscles: targetMuscles);
  }
}
