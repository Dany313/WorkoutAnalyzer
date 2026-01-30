abstract class WorkoutEvent {
  const WorkoutEvent();
}

class GetWorkoutsEvent extends WorkoutEvent {
  const GetWorkoutsEvent({required this.planId});

  final String planId;
}

class AddWorkoutEvent extends WorkoutEvent {
  const AddWorkoutEvent({required this.planId});

  final String planId;
}

class UpdateWorkoutEvent extends WorkoutEvent {
  const UpdateWorkoutEvent({required this.id});

  final String id;
}

class RemoveWorkoutEvent extends WorkoutEvent {
  const RemoveWorkoutEvent({required this.id});

  final String id;
}

class WorkoutNameChanged extends WorkoutEvent {
  final String name;
  const WorkoutNameChanged(this.name);
}

