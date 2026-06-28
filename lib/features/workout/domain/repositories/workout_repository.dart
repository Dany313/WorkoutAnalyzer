import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout_plan.dart';

abstract class WorkoutRepository {
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlans();
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlan(String id);
  Future<Either<Failure, void>> saveWorkoutPlan(WorkoutPlan plan);
  Future<Either<Failure, void>> deleteWorkoutPlan(String id);
}
