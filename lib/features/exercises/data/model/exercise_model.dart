import 'dart:convert';

import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/entity/exercise_entity.dart';

class ExerciseModel {
  final String id;
  final String name;
  final String description;
  final String targetMuscles;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.targetMuscles,
  });

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap((jsonDecode(source) as DataMap));

  ExerciseModel.fromMap(DataMap map)
    : this(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        targetMuscles: map['targetMuscles'] as String,
      );

  DataMap toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'targetMuscles': targetMuscles,
  };

  String toJson() => jsonEncode(toMap());

  ExerciseModel copyWith({
    String? id,
    String? name,
    String? description,
    String? targetMuscles,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetMuscles: targetMuscles ?? this.targetMuscles,
    );
  }

  ExerciseEntity toEntity() {

    // if(targetMuscles.isEmpty){
    //   return ExerciseEntity(
    //     id: id,
    //     name: name,
    //     description: description,
    //     targetMuscles: {},
    //   );
    // }

    final decoded = jsonDecode(targetMuscles) as Map<String, dynamic>;
    final muscleMap = Map<MuscleGroups, int>.fromEntries(
      decoded.entries.map(
        (e) => MapEntry(
          MuscleGroups.values.firstWhere((m) => m.name == e.key),
          int.parse(e.value.toString()),
        ),
      ),
    );

    return ExerciseEntity(
      id: id,
      name: name,
      description: description,
      targetMuscles: muscleMap,
    );
  }

  ExerciseModel.empty()
    : this(
        id: 'empty_string',
        name: 'empty_string',
        description: 'empty_string',
        targetMuscles: "{}",
      );
}
