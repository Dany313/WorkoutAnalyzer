import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../repository/exercise_repository.dart';

@lazySingleton
class DeleteExerciseUseCase implements UseCaseWithParams<void, String> {
  final ExerciseRepository repository;

  DeleteExerciseUseCase(this.repository);

  @override
  ResultFuture<void> call(String id) async {
    if (id.isEmpty) return Left(ServerFailure('Id vuoto'));
    return await repository.deleteExerciseById(id);
  }
}
