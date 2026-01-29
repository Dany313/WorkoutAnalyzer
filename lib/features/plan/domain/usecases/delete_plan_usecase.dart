import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/features/plan/domain/repository/plan_repository.dart';

@lazySingleton
class DeletePlanUseCase implements UseCaseWithParams<void, String> {
  final PlanRepository _repository;

  DeletePlanUseCase(this._repository);

  @override
  ResultFuture<void> call(String id) async =>
      await _repository.deletePlanById(id);
}
