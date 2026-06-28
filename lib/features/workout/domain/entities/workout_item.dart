import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise.dart';

part 'workout_item.freezed.dart';
part 'workout_item.g.dart';

@freezed
abstract class WorkoutItem with _$WorkoutItem {
  const factory WorkoutItem.single({
    required Exercise exercise,
  }) = SingleWorkoutItem;

  const factory WorkoutItem.superset({
    required List<Exercise> exercises,
  }) = SupersetWorkoutItem;

  factory WorkoutItem.fromJson(Map<String, dynamic> json) =>
      _$WorkoutItemFromJson(json);
}
