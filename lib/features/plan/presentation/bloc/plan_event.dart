abstract class PlanEvent {
  const PlanEvent();
}

class GetPlansEvent extends PlanEvent {
  const GetPlansEvent();
}

class AddPlanEvent extends PlanEvent {
  const AddPlanEvent({required this.name});

  final String name;
}

class RemovePlanEvent extends PlanEvent {
  const RemovePlanEvent({required this.id});

  final String id;
}
