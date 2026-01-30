// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlanTable extends Plan with TableInfo<$PlanTable, PlanData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 6,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $PlanTable createAlias(String alias) {
    return $PlanTable(attachedDatabase, alias);
  }
}

class PlanData extends DataClass implements Insertable<PlanData> {
  final int id;
  final String name;
  const PlanData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlanCompanion toCompanion(bool nullToAbsent) {
    return PlanCompanion(id: Value(id), name: Value(name));
  }

  factory PlanData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PlanData copyWith({int? id, String? name}) =>
      PlanData(id: id ?? this.id, name: name ?? this.name);
  PlanData copyWithCompanion(PlanCompanion data) {
    return PlanData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanData && other.id == this.id && other.name == this.name);
}

class PlanCompanion extends UpdateCompanion<PlanData> {
  final Value<int> id;
  final Value<String> name;
  const PlanCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PlanCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<PlanData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PlanCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return PlanCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $WorkoutTable extends Workout with TableInfo<$WorkoutTable, WorkoutData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 6,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "plan" (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, planId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      planId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}plan_id'],
          )!,
    );
  }

  @override
  $WorkoutTable createAlias(String alias) {
    return $WorkoutTable(attachedDatabase, alias);
  }
}

class WorkoutData extends DataClass implements Insertable<WorkoutData> {
  final int id;
  final String name;
  final int planId;
  const WorkoutData({
    required this.id,
    required this.name,
    required this.planId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['plan_id'] = Variable<int>(planId);
    return map;
  }

  WorkoutCompanion toCompanion(bool nullToAbsent) {
    return WorkoutCompanion(
      id: Value(id),
      name: Value(name),
      planId: Value(planId),
    );
  }

  factory WorkoutData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      planId: serializer.fromJson<int>(json['planId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'planId': serializer.toJson<int>(planId),
    };
  }

  WorkoutData copyWith({int? id, String? name, int? planId}) => WorkoutData(
    id: id ?? this.id,
    name: name ?? this.name,
    planId: planId ?? this.planId,
  );
  WorkoutData copyWithCompanion(WorkoutCompanion data) {
    return WorkoutData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      planId: data.planId.present ? data.planId.value : this.planId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('planId: $planId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, planId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutData &&
          other.id == this.id &&
          other.name == this.name &&
          other.planId == this.planId);
}

class WorkoutCompanion extends UpdateCompanion<WorkoutData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> planId;
  const WorkoutCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.planId = const Value.absent(),
  });
  WorkoutCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int planId,
  }) : name = Value(name),
       planId = Value(planId);
  static Insertable<WorkoutData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? planId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (planId != null) 'plan_id': planId,
    });
  }

  WorkoutCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? planId,
  }) {
    return WorkoutCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      planId: planId ?? this.planId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('planId: $planId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlanTable plan = $PlanTable(this);
  late final $WorkoutTable workout = $WorkoutTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [plan, workout];
}

typedef $$PlanTableCreateCompanionBuilder =
    PlanCompanion Function({Value<int> id, required String name});
typedef $$PlanTableUpdateCompanionBuilder =
    PlanCompanion Function({Value<int> id, Value<String> name});

final class $$PlanTableReferences
    extends BaseReferences<_$AppDatabase, $PlanTable, PlanData> {
  $$PlanTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutTable, List<WorkoutData>>
  _workoutRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workout,
    aliasName: $_aliasNameGenerator(db.plan.id, db.workout.planId),
  );

  $$WorkoutTableProcessedTableManager get workoutRefs {
    final manager = $$WorkoutTableTableManager(
      $_db,
      $_db.workout,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlanTableFilterComposer extends Composer<_$AppDatabase, $PlanTable> {
  $$PlanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutRefs(
    Expression<bool> Function($$WorkoutTableFilterComposer f) f,
  ) {
    final $$WorkoutTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workout,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTableFilterComposer(
            $db: $db,
            $table: $db.workout,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlanTableOrderingComposer extends Composer<_$AppDatabase, $PlanTable> {
  $$PlanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanTable> {
  $$PlanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> workoutRefs<T extends Object>(
    Expression<T> Function($$WorkoutTableAnnotationComposer a) f,
  ) {
    final $$WorkoutTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workout,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutTableAnnotationComposer(
            $db: $db,
            $table: $db.workout,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanTable,
          PlanData,
          $$PlanTableFilterComposer,
          $$PlanTableOrderingComposer,
          $$PlanTableAnnotationComposer,
          $$PlanTableCreateCompanionBuilder,
          $$PlanTableUpdateCompanionBuilder,
          (PlanData, $$PlanTableReferences),
          PlanData,
          PrefetchHooks Function({bool workoutRefs})
        > {
  $$PlanTableTableManager(_$AppDatabase db, $PlanTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PlanTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PlanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PlanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => PlanCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  PlanCompanion.insert(id: id, name: name),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PlanTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({workoutRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workoutRefs) db.workout],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutRefs)
                    await $_getPrefetchedData<
                      PlanData,
                      $PlanTable,
                      WorkoutData
                    >(
                      currentTable: table,
                      referencedTable: $$PlanTableReferences._workoutRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlanTableReferences(db, table, p0).workoutRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.planId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanTable,
      PlanData,
      $$PlanTableFilterComposer,
      $$PlanTableOrderingComposer,
      $$PlanTableAnnotationComposer,
      $$PlanTableCreateCompanionBuilder,
      $$PlanTableUpdateCompanionBuilder,
      (PlanData, $$PlanTableReferences),
      PlanData,
      PrefetchHooks Function({bool workoutRefs})
    >;
typedef $$WorkoutTableCreateCompanionBuilder =
    WorkoutCompanion Function({
      Value<int> id,
      required String name,
      required int planId,
    });
typedef $$WorkoutTableUpdateCompanionBuilder =
    WorkoutCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> planId,
    });

final class $$WorkoutTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutTable, WorkoutData> {
  $$WorkoutTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlanTable _planIdTable(_$AppDatabase db) =>
      db.plan.createAlias($_aliasNameGenerator(db.workout.planId, db.plan.id));

  $$PlanTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$PlanTableTableManager(
      $_db,
      $_db.plan,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTable> {
  $$WorkoutTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$PlanTableFilterComposer get planId {
    final $$PlanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanTableFilterComposer(
            $db: $db,
            $table: $db.plan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTable> {
  $$WorkoutTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlanTableOrderingComposer get planId {
    final $$PlanTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanTableOrderingComposer(
            $db: $db,
            $table: $db.plan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTable> {
  $$WorkoutTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$PlanTableAnnotationComposer get planId {
    final $$PlanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanTableAnnotationComposer(
            $db: $db,
            $table: $db.plan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutTable,
          WorkoutData,
          $$WorkoutTableFilterComposer,
          $$WorkoutTableOrderingComposer,
          $$WorkoutTableAnnotationComposer,
          $$WorkoutTableCreateCompanionBuilder,
          $$WorkoutTableUpdateCompanionBuilder,
          (WorkoutData, $$WorkoutTableReferences),
          WorkoutData,
          PrefetchHooks Function({bool planId})
        > {
  $$WorkoutTableTableManager(_$AppDatabase db, $WorkoutTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorkoutTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorkoutTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WorkoutTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> planId = const Value.absent(),
              }) => WorkoutCompanion(id: id, name: name, planId: planId),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int planId,
              }) => WorkoutCompanion.insert(id: id, name: name, planId: planId),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WorkoutTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (planId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.planId,
                            referencedTable: $$WorkoutTableReferences
                                ._planIdTable(db),
                            referencedColumn:
                                $$WorkoutTableReferences._planIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutTable,
      WorkoutData,
      $$WorkoutTableFilterComposer,
      $$WorkoutTableOrderingComposer,
      $$WorkoutTableAnnotationComposer,
      $$WorkoutTableCreateCompanionBuilder,
      $$WorkoutTableUpdateCompanionBuilder,
      (WorkoutData, $$WorkoutTableReferences),
      WorkoutData,
      PrefetchHooks Function({bool planId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlanTableTableManager get plan => $$PlanTableTableManager(_db, _db.plan);
  $$WorkoutTableTableManager get workout =>
      $$WorkoutTableTableManager(_db, _db.workout);
}
