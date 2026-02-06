import 'dart:convert';

import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/entity/training.dart';

class TrainingExerciseModel extends TrainingExerciseEntity {
  const TrainingExerciseModel({
    required super.id,
    required super.exerciseId,
    required super.sets,
    required super.reps,
    required super.restSeconds,
    required super.rpe,
  });

  factory TrainingExerciseModel.fromJson(String source) =>
      TrainingExerciseModel.fromMap((jsonDecode(source) as DataMap));

  TrainingExerciseModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          exerciseId: map['exerciseId'] as String,
          sets: map['sets'] as int,
          reps: map['reps'] as int,
          restSeconds: map['restSeconds'] as int,
          rpe: map['rpe'] as int,
        );

  DataMap toMap() => {
        'id': id,
        'exerciseId': exerciseId,
        'sets': sets,
        'reps': reps,
        'restSeconds': restSeconds,
        'rpe': rpe,
      };

  String toJson() => jsonEncode(toMap());

  TrainingExerciseModel copyWith({
    String? id,
    String? exerciseId,
    int? sets,
    int? reps,
    int? restSeconds,
    int? rpe,
  }) {
    return TrainingExerciseModel(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      rpe: rpe ?? this.rpe,
    );
  }

  TrainingExerciseEntity toEntity() {
    return TrainingExerciseEntity(
      id: id,
      exerciseId: exerciseId,
      sets: sets,
      reps: reps,
      restSeconds: restSeconds,
      rpe: rpe,
    );
  }

  const TrainingExerciseModel.empty()
      : this(
          id: 'empty_string',
          exerciseId: 'empty_string',
          sets: 0,
          reps: 0,
          restSeconds: 0,
          rpe: 0,
        );
}
