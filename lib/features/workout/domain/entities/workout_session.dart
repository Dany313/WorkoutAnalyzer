import 'package:freezed_annotation/freezed_annotation.dart';
import 'workout_item.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String name,
    required List<WorkoutItem> items,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);
}
