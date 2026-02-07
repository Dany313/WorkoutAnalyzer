import 'package:equatable/equatable.dart';
import 'package:workout_app/features/exercises/domain/entity/exercise_entity.dart';
import 'package:workout_app/features/exercises/presentation/forms/exercise_form.dart';
import 'package:workout_app/features/training/domain/entity/training.dart';
import 'package:workout_app/features/training/presentation/forms/training_form.dart';

enum TrainingStatus {
  initial,
  loading,
  success,
  failure,
  creating,
  removing,
  updating,
  reloading,
}

class TrainingState extends Equatable {
  final TrainingStatus status;
  final List<TrainingExerciseEntity> trainingExercises;
  final List<ExerciseEntity> exercises;
  final SetsInput sets;
  final RepsInput reps;
  final RestSecondsInput restSeconds;
  final RpeInput rpe;
  final Name exerciseName;
  final Description exerciseDescription;
  final TargetMuscles targetMuscles;
  final bool useExistingExercise;
  final String? selectedExerciseId;
  final bool isValid;
  final String? errorMessage;
  final String? workoutId;

  const TrainingState({
    this.status = TrainingStatus.initial,
    this.trainingExercises = const [],
    this.exercises = const [],
    this.sets = const SetsInput.pure(),
    this.reps = const RepsInput.pure(),
    this.restSeconds = const RestSecondsInput.pure(),
    this.rpe = const RpeInput.pure(),
    this.exerciseName = const Name.pure(),
    this.exerciseDescription = const Description.pure(),
    this.targetMuscles = const TargetMuscles.pure(),
    this.useExistingExercise = true,
    this.selectedExerciseId,
    this.isValid = false,
    this.errorMessage,
    this.workoutId,
  });

  TrainingState copyWith({
    TrainingStatus? status,
    List<TrainingExerciseEntity>? trainingExercises,
    List<ExerciseEntity>? exercises,
    SetsInput? sets,
    RepsInput? reps,
    RestSecondsInput? restSeconds,
    RpeInput? rpe,
    Name? exerciseName,
    Description? exerciseDescription,
    TargetMuscles? targetMuscles,
    bool? useExistingExercise,
    String? selectedExerciseId,
    bool? isValid,
    String? errorMessage,
    String? workoutId,
  }) {
    return TrainingState(
      status: status ?? this.status,
      trainingExercises: trainingExercises ?? this.trainingExercises,
      exercises: exercises ?? this.exercises,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      rpe: rpe ?? this.rpe,
      exerciseName: exerciseName ?? this.exerciseName,
      exerciseDescription: exerciseDescription ?? this.exerciseDescription,
      targetMuscles: targetMuscles ?? this.targetMuscles,
      useExistingExercise: useExistingExercise ?? this.useExistingExercise,
      selectedExerciseId: selectedExerciseId ?? this.selectedExerciseId,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        trainingExercises,
        exercises,
        sets,
        reps,
        restSeconds,
        rpe,
        exerciseName,
        exerciseDescription,
        targetMuscles,
        useExistingExercise,
        selectedExerciseId,
        isValid,
        errorMessage,
        workoutId,
      ];
}
