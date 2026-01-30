import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
  final String id;
  final String name;
  final String planId;

  const WorkoutEntity({
    required this.id,
    required this.name,
    required this.planId,
  });

  const WorkoutEntity.empty()
      : this(id: 'empty_string', name: 'empty_string', planId: 'empty_string');

  @override
  List<Object?> get props => [id];
}
