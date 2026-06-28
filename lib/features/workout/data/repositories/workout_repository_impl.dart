import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final List<WorkoutPlan> _mockPlans = [];

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlans() async {
    // Simulate network or DB delay
    await Future.delayed(const Duration(milliseconds: 500));
    return Right([..._mockPlans]);
  }

  @override
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlan(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final plan = _mockPlans.firstWhere((p) => p.id == id);
      return Right(plan);
    } catch (e) {
      return const Left(CacheFailure("Plan not found"));
    }
  }

  @override
  Future<Either<Failure, void>> saveWorkoutPlan(WorkoutPlan plan) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockPlans.indexWhere((p) => p.id == plan.id);
    if (index != -1) {
      _mockPlans[index] = plan;
    } else {
      _mockPlans.add(plan);
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteWorkoutPlan(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockPlans.removeWhere((p) => p.id == id);
    return const Right(null);
  }
}
