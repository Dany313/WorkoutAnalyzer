import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../../../../core/enums/muscle_goups.dart';
import '../repository/exercise_repository.dart';

@lazySingleton
class UpdateExerciseUseCase implements UseCaseWithParams<void, UpdateExerciseParams> {
  final ExerciseRepository repository;

  UpdateExerciseUseCase(this.repository);
  Either<Failure, bool> _inputValidation(UpdateExerciseParams params){
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
  ResultFuture<void> call(UpdateExerciseParams params) async {
    // Validazione
    var validation = _inputValidation(params);

    if(validation.isLeft()){
      return validation;
    }

    return await repository.updateExercise(params);
  }
}

class UpdateExerciseParams {
  final String id;
  final String name;
  final String description;
  final Map<MuscleGroups, int> targetMuscles;


  const UpdateExerciseParams({required this.id, required this.name, required this.description, required this.targetMuscles});

  UpdateExerciseParams copyWith({String? id, String? name, String? description, Map<MuscleGroups, int>? targetMuscles}) {
    return UpdateExerciseParams(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetMuscles: targetMuscles ?? this.targetMuscles,
    );
  }
}
