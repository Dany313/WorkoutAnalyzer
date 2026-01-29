import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/features/plan/domain/entity/plan_entity.dart';

import '../repository/plan_repository.dart';

@lazySingleton
class GetPlansUseCase implements UseCaseWithoutParams<List<PlanEntity>> {
  final PlanRepository _repository;

  GetPlansUseCase(this._repository);

  @override
  ResultFuture<List<PlanEntity>> call() async =>
      await _repository.getPlansList();
}
