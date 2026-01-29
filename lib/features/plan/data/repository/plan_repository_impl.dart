import 'dart:developer' as console;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/error/failure.dart';
import 'package:workout_app/core/utils/typedef.dart';

import '../../../../core/error/exeptions.dart';
import '../../domain/entity/plan_entity.dart';
import '../../domain/repository/plan_repository.dart';
import '../datasources/plan_local_datasource.dart';

@LazySingleton(as: PlanRepository)
class PlanRepositoryImpl extends PlanRepository {
  late final PlanDataSource _localDataSource;

  PlanRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<void> addPlan(String name) async {
    try {
      await _localDataSource.savePlan(name);
      return Right(null);
    } catch (e) {
      console.log('addPlan error: ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deletePlanById(String id) async {
    try {
      await _localDataSource.deletePlan(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<PlanEntity> getPlanById(String id) async {
    try {
      final plan = await _localDataSource.getPlanById(id);
      return Right(plan.toEntity());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<List<PlanEntity>> getPlansList() async {
    try {
      final plans = await _localDataSource.getPlans();
      return Right(plans.map((plan) => plan.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
