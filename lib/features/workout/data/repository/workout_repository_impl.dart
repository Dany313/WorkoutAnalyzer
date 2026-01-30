import 'dart:developer' as console;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/error/failure.dart';
import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/usecases/update_workout_usecase.dart';
import '../../domain/entity/workout_entity.dart';
import '../../domain/repository/workout_repository.dart';
import '../datasources/workout_local_datasource.dart';

@LazySingleton(as: WorkoutRepository)
class WorkoutRepositoryImpl extends WorkoutRepository {
  final WorkoutDataSource _localDataSource;

  WorkoutRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<void> addWorkout(String name, String planId) async {
    try {
      await _localDataSource.saveWorkout(name, planId);
      return Right(null);
    } catch (e) {
      console.log('addWorkout error: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteWorkoutById(String id) async {
    try {
      await _localDataSource.deleteWorkout(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<WorkoutEntity> getWorkoutById(String id) async {
    try {
      final workout = await _localDataSource.getWorkoutById(id);
      return Right(workout.toEntity());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<List<WorkoutEntity>> getWorkoutsList(String planId) async {
    try {
      final workouts = await _localDataSource.getWorkouts(planId);
      return Right(workouts.map((w) => w.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<void> updateWorkout(UpdateWorkoutParams params) async {
    try {
      await _localDataSource.updateWorkout(params);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
