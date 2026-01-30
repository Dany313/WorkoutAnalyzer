import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/features/plan/domain/entity/plan_entity.dart';
import 'package:workout_app/features/plan/domain/usecases/update_plan_usecase.dart';

abstract class PlanRepository {
  ResultFuture<void> addPlan( String name);
  ResultFuture<List<PlanEntity>> getPlansList();
  ResultFuture<PlanEntity> getPlanById(String id);
  ResultFuture<void> deletePlanById(String id);
  ResultFuture<void> updatePlan(UpdatePlanParams params);
}
