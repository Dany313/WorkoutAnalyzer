import 'dart:convert';

import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/entity/workout_entity.dart';

class WorkoutModel extends WorkoutEntity {
  const WorkoutModel({
    required super.id,
    required super.name,
    required super.planId,
  });

  factory WorkoutModel.fromJson(String source) =>
      WorkoutModel.fromMap((jsonDecode(source) as DataMap));

  WorkoutModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          planId: map['planId'] as String,
        );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'planId': planId,
      };

  String toJson() => jsonEncode(toMap());

  WorkoutModel copyWith({
    String? id,
    String? name,
    String? planId,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      name: name ?? this.name,
      planId: planId ?? this.planId,
    );
  }

  WorkoutEntity toEntity() {
    return WorkoutEntity(id: id, name: name, planId: planId);
  }

  const WorkoutModel.empty()
      : this(id: 'empty_string', name: 'empty_string', planId: 'empty_string');
}
