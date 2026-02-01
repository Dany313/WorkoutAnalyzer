import '../../domain/entity/exercise_entity.dart';
import '../forms/exercise_form.dart';

enum ExerciseStatus { initial, loading, success, failure, creating, removing, updating, reloading }

class ExerciseState {
  final List<ExerciseEntity> exercises;
  final ExerciseStatus status;
  final String? errorMessage;

  // Campi Formz
  final Name exerciseName;
  final bool isValid;

  const ExerciseState({
    this.exercises = const [],
    this.status = ExerciseStatus.initial,
    this.errorMessage,
    this.exerciseName = const Name.pure(),
    this.isValid = false,
  });

  ExerciseState copyWith({
    List<ExerciseEntity>? workouts,
    ExerciseStatus? status,
    String? errorMessage,
    Name? exerciseName,
    bool? isValid,
  }) {
    return ExerciseState(
      exercises: workouts ?? this.exercises,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      exerciseName: exerciseName ?? this.exerciseName,
      isValid: isValid ?? this.isValid,
    );
  }
}
