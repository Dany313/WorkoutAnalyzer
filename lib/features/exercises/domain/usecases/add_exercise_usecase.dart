import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../entity/exercise_entity.dart';
import '../repository/exercise_repository.dart';

@lazySingleton
class AddExerciseUseCase
    implements UseCaseWithParams<String, AddExerciseParams> {
  final ExerciseRepository repository;

  AddExerciseUseCase(this.repository);

  Either<Failure, bool> _inputValidation(AddExerciseParams params){
    if (params.name.isEmpty) {
      return Left(ValidationFailure("name is empty"));
    }
    if (params.name.length < 6) {
      return Left(ValidationFailure('name too short'));
    }
    if (params.name.length > 32) {
      return Left(ValidationFailure('name too long'));
    }
    return Right(true);
  }

  @override
  ResultFuture<String> call(AddExerciseParams params) async {
    // Validazione
    var validation = _inputValidation(params);

    if (validation.isLeft()) {
      return Left(validation.fold((failure) => failure, (_) => ValidationFailure('invalid input')));
    }

    return await repository.addExercise(params);
  }
}

class AddExerciseParams {
  final String name;
  final String description;
  final Map<MuscleGroups, int> targetMuscles;

  const AddExerciseParams({required this.name, required this.description, required this.targetMuscles});

  AddExerciseParams copyWith({String? name, String? description, Map<MuscleGroups, int>? targetMuscles}) {
    return AddExerciseParams(name: name ?? this.name, description: description ?? this.description, targetMuscles: targetMuscles ?? this.targetMuscles);
  }
}
