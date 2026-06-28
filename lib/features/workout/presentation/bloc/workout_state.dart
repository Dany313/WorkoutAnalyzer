import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/workout_plan.dart';

part 'workout_state.freezed.dart';

@freezed
abstract class WorkoutState with _$WorkoutState {
  const factory WorkoutState.initial() = _Initial;
  const factory WorkoutState.loading() = _Loading;
  const factory WorkoutState.loaded({required List<WorkoutPlan> plans}) =
      _Loaded;
  const factory WorkoutState.error({required String message}) = _Error;
}
