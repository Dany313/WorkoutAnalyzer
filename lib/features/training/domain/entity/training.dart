import 'package:equatable/equatable.dart';

class TrainingExerciseEntity extends Equatable {
  final String id;
  final String exerciseId;
  final int sets;
  final int reps;
  final int restSeconds;
  final int rpe;


  const TrainingExerciseEntity({
    required this.id,
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.rpe,
  });

  const TrainingExerciseEntity.empty()
      : this(id: 'empty_string', exerciseId: 'empty_string', sets: 0, reps: 0, restSeconds: 0, rpe: 0);

  @override
  List<Object?> get props => [id];
}
