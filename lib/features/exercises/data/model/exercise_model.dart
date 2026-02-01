import 'dart:convert';

import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/entity/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  const ExerciseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.targetMuscles
  });

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap((jsonDecode(source) as DataMap));

  ExerciseModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          description: map['description'] as String,
          targetMuscles: map['targetMuscles'] as Map<MuscleGroups, int>,
        );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'targetMuscles': targetMuscles
      };

  String toJson() => jsonEncode(toMap());

  ExerciseModel copyWith({
    String? id,
    String? name,
    String? description,
    Map<MuscleGroups, int>? targetMuscles,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetMuscles: targetMuscles ?? this.targetMuscles
    );
  }

  ExerciseEntity toEntity() {
    return ExerciseEntity(id: id, name: name, description: description, targetMuscles: targetMuscles);
  }

  ExerciseModel.empty()
      : this(id: 'empty_string', name: 'empty_string', description: 'empty_string', targetMuscles: {});
}
