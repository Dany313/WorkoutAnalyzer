import 'package:equatable/equatable.dart';

import '../../../../core/enums/muscle_goups.dart';

class ExerciseEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final Map<MuscleGroups, int> targetMuscles;


  const ExerciseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.targetMuscles,
  });

  const ExerciseEntity.empty()
      : this(id: 'empty_string', 
      name: 'empty_string', 
      description: 'empty_string', 
      targetMuscles: const {}
  );

  @override
  List<Object?> get props => [id];
}
