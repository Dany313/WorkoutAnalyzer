import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/features/plan/domain/usecases/update_plan_usecase.dart';

import '../../../../database.dart';
import '../model/plan_model.dart';

abstract class PlanDataSource {
  Future<List<PlanModel>> getPlans();
  Future<void> savePlan(String name);
  Future<void> deletePlan(String planId);
  Future<PlanModel> getPlanById(String planId);
  Future<void> updatePlan(UpdatePlanParams params);
}

@LazySingleton(as: PlanDataSource)
class PlanLocalDataSourceImpl implements PlanDataSource {
  final AppDatabase database;

  PlanLocalDataSourceImpl(this.database);

  @override
  Future<void> deletePlan(String planId) async {
    await (database.delete(database.plan)
      ..where((t) => t.id.equals(int.parse(planId)))).go();
    return Future.value();
  }

  @override
  Future<List<PlanModel>> getPlans() async {
    List<PlanModel> result =
        (await database.select(database.plan).get())
            .map(
              (e) =>
                  PlanModel(id: e.id.toString(), name: e.name, workoutIds: []),
            )
            .toList();
    return Future.value(result);
  }

  @override
  Future<void> savePlan(String name) async {
    await database.into(database.plan).insert(PlanCompanion.insert(name: name));
    return Future.value();
  }

  @override
  Future<PlanModel> getPlanById(String planId) async {
    final result = await  (database.select(database.plan)..where((t) => t.id.equals(int.parse(planId)))).getSingle();
    return PlanModel(id: result.id.toString(), name: result.name, workoutIds: []);
  }

  @override
  Future<void> updatePlan(UpdatePlanParams params) {
    return (database.update(database.plan)
      ..where((t) => t.id.equals(int.parse(params.id)))
    ).write(PlanCompanion(
      name: Value(params.name),
    ),
    );
  }
}
