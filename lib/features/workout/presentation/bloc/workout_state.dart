import '../../domain/entity/workout_entity.dart';
import '../forms/workout_form.dart';

enum WorkoutStatus { initial, loading, success, failure, creating, removing, updating, reloading }

class WorkoutState {
  final List<WorkoutEntity> workouts;
  final WorkoutStatus status;
  final String? errorMessage;

  // Campi Formz
  final Name workoutName;
  final bool isValid;

  const WorkoutState({
    this.workouts = const [],
    this.status = WorkoutStatus.initial,
    this.errorMessage,
    this.workoutName = const Name.pure(),
    this.isValid = false,
  });

  WorkoutState copyWith({
    List<WorkoutEntity>? workouts,
    WorkoutStatus? status,
    String? errorMessage,
    Name? workoutName,
    bool? isValid,
  }) {
    return WorkoutState(
      workouts: workouts ?? this.workouts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      workoutName: workoutName ?? this.workoutName,
      isValid: isValid ?? this.isValid,
    );
  }
}
