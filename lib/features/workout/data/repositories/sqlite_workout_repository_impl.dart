import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/repositories/workout_repository.dart';

class SqliteWorkoutRepositoryImpl implements WorkoutRepository {
  final DatabaseHelper dbHelper;

  SqliteWorkoutRepositoryImpl({required this.dbHelper});

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlans() async {
    try {
      final db = await dbHelper.database;
      final maps = await db.query('workout_plans');
      final plans = maps.map((map) {
        final data = jsonDecode(map['data'] as String);
        return WorkoutPlan.fromJson(data);
      }).toList();
      return Right(plans);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlan(String id) async {
    try {
      final db = await dbHelper.database;
      final maps = await db.query('workout_plans', where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        final data = jsonDecode(maps.first['data'] as String);
        return Right(WorkoutPlan.fromJson(data));
      } else {
        return const Left(CacheFailure("Plan not found"));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveWorkoutPlan(WorkoutPlan plan) async {
    try {
      final db = await dbHelper.database;
      final dataString = jsonEncode(plan.toJson());
      await db.insert(
        'workout_plans',
        {'id': plan.id, 'data': dataString},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkoutPlan(String id) async {
    try {
      final db = await dbHelper.database;
      await db.delete('workout_plans', where: 'id = ?', whereArgs: [id]);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
