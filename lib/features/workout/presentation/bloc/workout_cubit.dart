import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/entities/workout_plan.dart';
import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository repository;

  WorkoutCubit({required this.repository})
      : super(const WorkoutState.initial());

  Future<void> loadPlans() async {
    emit(const WorkoutState.loading());
    final failureOrPlans = await repository.getWorkoutPlans();

    failureOrPlans.fold(
      (failure) => emit(WorkoutState.error(message: failure.message)),
      (plans) => emit(WorkoutState.loaded(plans: plans)),
    );
  }

  Future<void> savePlan(WorkoutPlan plan) async {
    final failureOrSuccess = await repository.saveWorkoutPlan(plan);
    failureOrSuccess.fold(
      (failure) => emit(WorkoutState.error(message: failure.message)),
      (_) => loadPlans(),
    );
  }

  Future<void> deletePlan(String id) async {
    final failureOrSuccess = await repository.deleteWorkoutPlan(id);
    failureOrSuccess.fold(
      (failure) => emit(WorkoutState.error(message: failure.message)),
      (_) => loadPlans(),
    );
  }
}
