import 'dart:developer' as console;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/error/failure.dart';
import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/usecases/add_exercise_usecase.dart';
import '../../domain/usecases/update_exercise_usecase.dart';
import '../../domain/entity/exercise_entity.dart';
import '../../domain/repository/exercise_repository.dart';
import '../datasources/workout_local_datasource.dart';

@LazySingleton(as: ExerciseRepository)
class ExerciseRepositoryImpl extends ExerciseRepository {
  final ExerciseDataSource _localDataSource;

  ExerciseRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<void> addExercise(AddExerciseParams params) async {
    try {
      await _localDataSource.saveExercise(params);
      return Right(null);
    } catch (e) {
      console.log('addExercise error: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteExerciseById(String id) async {
    try {
      await _localDataSource.deleteExercise(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<ExerciseEntity> getExerciseById(String id) async {
    try {
      final result = await _localDataSource.getExerciseById(id);
      return Right(result.toEntity());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<List<ExerciseEntity>> getExercisesList() async {
    try {
      final result = await _localDataSource.getExercises();
      return Right(result.map((w) => w.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<void> updateExercise(UpdateExerciseParams params) async {
    try {
      await _localDataSource.updateExercise(params);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
