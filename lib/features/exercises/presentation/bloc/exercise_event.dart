import '../../../../core/enums/muscle_goups.dart';

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

class ExerciseDescriptionChanged extends ExerciseEvent {
  final String description;
  const ExerciseDescriptionChanged(this.description);
}

class ExerciseTargetMuscleAdded extends ExerciseEvent {
  final MuscleGroups muscle;
  final int percentage;
  const ExerciseTargetMuscleAdded({
    required this.muscle,
    required this.percentage,
  });
}

class ExerciseTargetMuscleRemoved extends ExerciseEvent {
  final MuscleGroups muscle;
  const ExerciseTargetMuscleRemoved({required this.muscle});
}

class ExerciseTargetMusclePercentageChanged extends ExerciseEvent {
  final MuscleGroups muscle;
  final int percentage;
  const ExerciseTargetMusclePercentageChanged({
    required this.muscle,
    required this.percentage,
  });
}
