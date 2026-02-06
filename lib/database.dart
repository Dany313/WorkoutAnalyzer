import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
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
  TextColumn get description => text().withLength(min: 1, max: 256)();
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
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection()) {
    customStatement('''
      CREATE TABLE IF NOT EXISTS "workout" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "plan_id" INTEGER NOT NULL REFERENCES "plan" (id)
      )
    ''');
  }

  @override
  int get schemaVersion => 3;

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
}
