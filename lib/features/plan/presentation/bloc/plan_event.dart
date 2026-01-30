abstract class PlanEvent {
  const PlanEvent();
}

class GetPlansEvent extends PlanEvent {
  const GetPlansEvent();
}

class AddPlanEvent extends PlanEvent {
  const AddPlanEvent();
}

class UpdatePlanEvent extends PlanEvent {
  const UpdatePlanEvent({required this.id});

  final String id;
}

class RemovePlanEvent extends PlanEvent {
  const RemovePlanEvent({required this.id});

  final String id;
}

class PlanNameChanged extends PlanEvent {
  final String name;
  const PlanNameChanged(this.name);
}
