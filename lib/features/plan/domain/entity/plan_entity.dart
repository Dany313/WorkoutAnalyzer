import 'package:equatable/equatable.dart';

class PlanEntity extends Equatable {
  final String id;
  final String name;
  final List<String> workoutIds;

  const PlanEntity({
    required this.id,
    required this.name,
    required this.workoutIds,
  });

  const PlanEntity.empty()
    : this(
        id: 'empty_string',
        name: 'empty_string',
    workoutIds: const [],
      );

  @override
  List<Object?> get props => [id];
}
