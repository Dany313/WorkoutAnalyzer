import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import '../entity/exercise_entity.dart';
import '../repository/exercise_repository.dart';

@lazySingleton
class GetExercisesUseCase implements UseCaseWithoutParams<List<ExerciseEntity>> {
  final ExerciseRepository _repository;

  GetExercisesUseCase(this._repository);

  @override
  ResultFuture<List<ExerciseEntity>> call() async =>
      await _repository.getExercisesList();
}
