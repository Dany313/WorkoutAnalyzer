import 'package:equatable/equatable.dart';
import 'package:workout_app/features/exercises/domain/entity/exercise_entity.dart';

abstract class TrainingEvent extends Equatable {
  const TrainingEvent();

  @override
  List<Object?> get props => [];
}

class TrainingLoadRequested extends TrainingEvent {
  final String workoutId;

  const TrainingLoadRequested({required this.workoutId});

  @override
  List<Object?> get props => [workoutId];
}

class TrainingUseExistingExerciseToggled extends TrainingEvent {
  final bool useExisting;

  const TrainingUseExistingExerciseToggled({required this.useExisting});

  @override
  List<Object?> get props => [useExisting];
}

class TrainingExerciseSelected extends TrainingEvent {
  final String exerciseId;

  const TrainingExerciseSelected({required this.exerciseId});

  @override
  List<Object?> get props => [exerciseId];
}

class TrainingSetsChanged extends TrainingEvent {
  final String sets;

  const TrainingSetsChanged(this.sets);

  @override
  List<Object?> get props => [sets];
}

class TrainingRepsChanged extends TrainingEvent {
  final String reps;

  const TrainingRepsChanged(this.reps);

  @override
  List<Object?> get props => [reps];
}

class TrainingRestChanged extends TrainingEvent {
  final String restSeconds;

  const TrainingRestChanged(this.restSeconds);

  @override
  List<Object?> get props => [restSeconds];
}

class TrainingRpeChanged extends TrainingEvent {
  final String rpe;

  const TrainingRpeChanged(this.rpe);

  @override
  List<Object?> get props => [rpe];
}

class TrainingExerciseNameChanged extends TrainingEvent {
  final String name;

  const TrainingExerciseNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class TrainingExerciseDescriptionChanged extends TrainingEvent {
  final String description;

  const TrainingExerciseDescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class TrainingExerciseTargetMuscleAdded extends TrainingEvent {
  final MuscleGroups muscle;
  final int percentage;

  const TrainingExerciseTargetMuscleAdded({
    required this.muscle,
    required this.percentage,
  });

  @override
  List<Object?> get props => [muscle, percentage];
}

class TrainingExerciseTargetMuscleRemoved extends TrainingEvent {
  final MuscleGroups muscle;

  const TrainingExerciseTargetMuscleRemoved({required this.muscle});

  @override
  List<Object?> get props => [muscle];
}

class TrainingExerciseTargetMusclePercentageChanged extends TrainingEvent {
  final MuscleGroups muscle;
  final int percentage;

  const TrainingExerciseTargetMusclePercentageChanged({
    required this.muscle,
    required this.percentage,
  });

  @override
  List<Object?> get props => [muscle, percentage];
}

class TrainingExerciseAdded extends TrainingEvent {
  const TrainingExerciseAdded();
}

class TrainingExerciseRemoved extends TrainingEvent {
  final String id;

  const TrainingExerciseRemoved({required this.id});

  @override
  List<Object?> get props => [id];
}
