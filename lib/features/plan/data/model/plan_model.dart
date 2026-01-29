import 'dart:convert';

import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/entity/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    required super.id,
    required super.name,
    required super.workoutIds,

  });

  factory PlanModel.fromJson(String source) =>
      PlanModel.fromMap((jsonDecode(source) as DataMap));

  PlanModel.fromMap(DataMap map)
    : this(
        id: map['id'] as String,
        name: map['name'] as String,
    workoutIds: (map['workoutIds'] as List).map((e) => e as String).toList(),
      );

  DataMap toMap() => {
    'id': id,
    'name': name,
    'workoutIds': workoutIds,
  };

  String toJson() => jsonEncode(toMap());

  PlanModel copyWith({
    String? id,
    String? name,
    List<String>? workoutIds,
  }) {
    return PlanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      workoutIds: workoutIds ?? this.workoutIds,
    );
  }

  PlanEntity toEntity() {
    return PlanEntity(
      id: id,
      name: name,
      workoutIds: workoutIds,
    );
  }

  const PlanModel.empty()
    : this(
        id: 'empty_string',
        name: 'empty_string',
    workoutIds: const [],
      );
}
