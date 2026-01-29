
import '../../domain/entity/plan_entity.dart';

abstract class PlanState {
  const PlanState();
}

class PlanInitialState extends PlanState {
  const PlanInitialState();
}

class PlanLoadingState extends PlanState {
  const PlanLoadingState();
}

class CreatingPlanState extends PlanState {
  const CreatingPlanState();
}

class PlanCreatedState extends PlanState {
  const PlanCreatedState();
}

class RemovingPlanState extends PlanState {
  const RemovingPlanState();
}

class PlanRemovedState extends PlanState {
  const PlanRemovedState();
}

class PlanLoadedState extends PlanState {
  final List<PlanEntity> plans;

  const PlanLoadedState(this.plans);
}

class PlanErrorState extends PlanState {
  final String message;

  const PlanErrorState(this.message);
}
