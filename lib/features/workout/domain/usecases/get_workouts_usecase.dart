import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/features/workout/domain/entity/workout_entity.dart';

import '../repository/workout_repository.dart';

@lazySingleton
class GetWorkoutsUseCase implements UseCaseWithParams<List<WorkoutEntity>, String> {
  final WorkoutRepository _repository;

  GetWorkoutsUseCase(this._repository);

  @override
  ResultFuture<List<WorkoutEntity>> call(String planId) async =>
      await _repository.getWorkoutsList(planId);
}
