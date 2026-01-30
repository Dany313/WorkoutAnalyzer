import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../repository/workout_repository.dart';

@lazySingleton
class AddWorkoutUseCase implements UseCaseWithParams<void, AddWorkoutParams> {
  final WorkoutRepository repository;

  AddWorkoutUseCase(this.repository);

  @override
  ResultFuture<void> call(AddWorkoutParams params) async {
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
    if (params.planId.isEmpty) {
      return Left(ServerFailure('Il planId non può essere vuoto'));
    }

    return await repository.addWorkout(params.name, params.planId);
  }
}

class AddWorkoutParams {
  final String name;
  final String planId;

  const AddWorkoutParams({required this.name, required this.planId});

  AddWorkoutParams copyWith({String? name, String? planId}) {
    return AddWorkoutParams(name: name ?? this.name, planId: planId ?? this.planId);
  }
}
