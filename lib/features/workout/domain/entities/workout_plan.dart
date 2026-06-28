import 'package:freezed_annotation/freezed_annotation.dart';
import 'workout_session.dart';

part 'workout_plan.freezed.dart';
part 'workout_plan.g.dart';

@freezed
abstract class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String id,
    required String name,
    required List<WorkoutSession> sessions,
  }) = _WorkoutPlan;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);
}
