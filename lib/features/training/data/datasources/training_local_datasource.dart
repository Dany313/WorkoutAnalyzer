import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../database.dart';
import '../../domain/usecase/add_train_ex_usecase.dart';
import '../../domain/usecase/update_train_ex_usecase.dart';
import '../model/training_model.dart';

abstract class TrainingDataSource {
  Future<List<TrainingExerciseModel>> getTrainExList(String workoutId);
  Future<void> saveTrainEx(AddTrainExParams params);
  Future<void> deleteTrainEx(String trainingId);
  Future<TrainingExerciseModel> getTrainExById(String trainingId);
  Future<void> updateTrainEx(UpdateTrainExParams params);
}

@LazySingleton(as: TrainingDataSource)
class TrainingLocalDataSourceImpl implements TrainingDataSource {
  final AppDatabase database;

  TrainingLocalDataSourceImpl(this.database);

  @override
  Future<void> deleteTrainEx(String trainingId) async {
    await (database.delete(database.training)
          ..where((t) => t.id.equals(int.parse(trainingId))))
        .go();
    return Future.value();
  }

  @override
  Future<List<TrainingExerciseModel>> getTrainExList(String workoutId) async {
    final result = (await (database.select(database.training)
          ..where((t) => t.workoutId.equals(int.parse(workoutId))))
        .get())
        .map(
          (e) => TrainingExerciseModel(
            id: e.id.toString(),
            exerciseId: e.exerciseId.toString(),
            sets: e.sets,
            reps: e.reps,
            restSeconds: e.restSeconds,
            rpe: e.rpe,
          ),
        )
        .toList();
    return Future.value(result);
  }

  @override
  Future<void> saveTrainEx(AddTrainExParams params) async {
    await database.into(database.training).insert(
          TrainingCompanion.insert(
            workoutId: int.parse(params.workoutId),
            exerciseId: int.parse(params.exerciseId),
            sets: params.sets,
            reps: params.reps,
            restSeconds: params.restSeconds,
            rpe: params.rpe,
          ),
        );
    return Future.value();
  }

  @override
  Future<TrainingExerciseModel> getTrainExById(String trainingId) async {
    final result = await (database.select(database.training)
          ..where((t) => t.id.equals(int.parse(trainingId))))
        .getSingle();
    return TrainingExerciseModel(
      id: result.id.toString(),
      exerciseId: result.exerciseId.toString(),
      sets: result.sets,
      reps: result.reps,
      restSeconds: result.restSeconds,
      rpe: result.rpe,
    );
  }

  @override
  Future<void> updateTrainEx(UpdateTrainExParams params) {
    return (database.update(database.training)
          ..where((t) => t.id.equals(int.parse(params.id))))
        .write(
      TrainingCompanion(
        exerciseId: Value(int.parse(params.exerciseId)),
        sets: Value(params.sets),
        reps: Value(params.reps),
        restSeconds: Value(params.restSeconds),
        rpe: Value(params.rpe),
      ),
    );
  }
}
