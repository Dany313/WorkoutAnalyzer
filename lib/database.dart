import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer;
part 'database.g.dart';

class Plan extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 6, max: 32)();
}

class Workout extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 6, max: 32)();
  late final planId = integer().references(Plan, #id)();
}

class Exercise extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 6, max: 32)();
  TextColumn get description => text().withLength(min: 0, max: 256)();
  TextColumn get targetMuscle => text().withLength(min: 1, max: 256)();
}

class Training extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer().references(Workout, #id)();
  IntColumn get exerciseId => integer().references(Exercise, #id)();
  IntColumn get sets => integer()();
  IntColumn get reps => integer()();
  IntColumn get restSeconds => integer()();
  IntColumn get rpe => integer()();
}

@DriftDatabase(tables: [Plan, Workout, Exercise, Training])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // In development, drop and recreate all tables on upgrade
      developer.log('Rebuilding database schema (hot reload detected)');

      await m.deleteTable('training');
      await m.deleteTable('exercise');
      await m.deleteTable('workout');
      await m.deleteTable('plan');

      await m.createAll();
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  /// Cancella tutti i record da tutte le tabelle
  Future<void> clearAllData() async {
    await delete(training).go();
    await delete(workout).go();
    await delete(exercise).go();
    await delete(plan).go();
    developer.log('Database cleared: all records deleted');
  }
}
