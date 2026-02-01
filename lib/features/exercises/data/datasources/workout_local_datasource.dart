import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../database.dart';
import '../../domain/usecases/add_exercise_usecase.dart';
import '../model/exercise_model.dart';
import '../../domain/usecases/update_exercise_usecase.dart';

abstract class ExerciseDataSource {
  Future<List<ExerciseModel>> getExercises();
  Future<void> saveExercise(AddExerciseParams params);
  Future<void> deleteExercise(String workoutId);
  Future<ExerciseModel> getExerciseById(String workoutId);
  Future<void> updateExercise(UpdateExerciseParams params);
}

@LazySingleton(as: ExerciseDataSource)
class ExerciseLocalDataSourceImpl implements ExerciseDataSource {
  final AppDatabase database;

  ExerciseLocalDataSourceImpl(this.database);

  @override
  Future<void> deleteExercise(String id) async {
    await (database.delete(database.exercise)
      ..where((t) => t.id.equals(int.parse(id)))).go();
    return Future.value();
  }

  @override
  Future<List<ExerciseModel>> getExercises() async {
    final result = (await (database.select(database.exercise)).get())
        .map((e) => ExerciseModel(id: e.id.toString(), name: e.name, description: e.description, targetMuscles: jsonDecode(e.targetMuscle)))
        .toList();

    return Future.value(result);
  }

  @override
  Future<void> saveExercise(AddExerciseParams params) async {
    await database.into(database.exercise).insert(
      ExerciseCompanion.insert(name: params.name, description: params.description, targetMuscle: jsonEncode(params.targetMuscles)),
    );
    return Future.value();
  }

  @override
  Future<ExerciseModel> getExerciseById(String id) async {
    final result = await (database.select(database.exercise)
          ..where((t) => t.id.equals(int.parse(id))))
        .getSingle();
    return ExerciseModel(id: result.id.toString(), name: result.name, description: result.description, targetMuscles: jsonDecode(result.targetMuscle));
  }

  @override
  Future<void> updateExercise(UpdateExerciseParams params) {
    return (database.update(database.exercise)
      ..where((t) => t.id.equals(int.parse(params.id))))
        .write(ExerciseCompanion(
          name: Value(params.name!),
          description: Value(params.description ?? ''),
          targetMuscle: Value(jsonEncode(params.targetMuscles!)),
        ));
  }
}
