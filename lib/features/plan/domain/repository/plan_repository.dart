import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/features/plan/domain/entity/plan_entity.dart';

abstract class PlanRepository {
  ResultFuture<void> addPlan( String name);
  ResultFuture<List<PlanEntity>> getPlansList();
  ResultFuture<PlanEntity> getPlanById(String id);
  ResultFuture<void> deletePlanById(String id);
}
