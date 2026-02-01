abstract class ExerciseEvent {
  const ExerciseEvent();
}

class GetExercisesEvent extends ExerciseEvent {
  const GetExercisesEvent();
}

class AddExerciseEvent extends ExerciseEvent {
  const AddExerciseEvent();
}

class UpdateExerciseEvent extends ExerciseEvent {
  const UpdateExerciseEvent({required this.id});
  final String id;
}

class RemoveExerciseEvent extends ExerciseEvent {
  const RemoveExerciseEvent({required this.id});

  final String id;
}

class ExerciseNameChanged extends ExerciseEvent {
  final String name;
  const ExerciseNameChanged(this.name);
}

