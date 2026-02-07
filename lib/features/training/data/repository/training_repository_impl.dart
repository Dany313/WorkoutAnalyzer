import 'dart:developer' as console;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/error/failure.dart';
import 'package:workout_app/core/utils/typedef.dart';
import '../../domain/entity/training.dart';
import '../../domain/repository/train_repository.dart';
import '../../domain/usecase/add_train_ex_usecase.dart';
import '../../domain/usecase/update_train_ex_usecase.dart';
import '../datasources/training_local_datasource.dart';

@LazySingleton(as: TrainRepository)
class TrainingRepositoryImpl extends TrainRepository {
  final TrainingDataSource _localDataSource;

  TrainingRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<void> addTrainEx(AddTrainExParams params) async {
    try {
      await _localDataSource.saveTrainEx(params);
      return Right(null);
    } catch (e) {
      console.log('addTrainEx error: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteTrainExById(String id) async {
    try {
      await _localDataSource.deleteTrainEx(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TrainingExerciseEntity> getTrainExById(String id) async {
    try {
      final trainingExercise = await _localDataSource.getTrainExById(id);
      return Right(trainingExercise.toEntity());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<List<TrainingExerciseEntity>> getTrainExList(
    String workoutId,
  ) async {
    try {
      final trainingExercises = await _localDataSource.getTrainExList(workoutId);
      return Right(trainingExercises.map((t) => t.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<void> updateTrainEx(UpdateTrainExParams params) async {
    try {
      await _localDataSource.updateTrainEx(params);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
