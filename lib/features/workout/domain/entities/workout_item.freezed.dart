// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
WorkoutItem _$WorkoutItemFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'single':
      return SingleWorkoutItem.fromJson(json);
    case 'superset':
      return SupersetWorkoutItem.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'WorkoutItem',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$WorkoutItem {
  /// Serializes this WorkoutItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WorkoutItem);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WorkoutItem()';
  }
}

/// @nodoc
class $WorkoutItemCopyWith<$Res> {
  $WorkoutItemCopyWith(WorkoutItem _, $Res Function(WorkoutItem) __);
}

/// Adds pattern-matching-related methods to [WorkoutItem].
extension WorkoutItemPatterns on WorkoutItem {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SingleWorkoutItem value)? single,
    TResult Function(SupersetWorkoutItem value)? superset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SingleWorkoutItem() when single != null:
        return single(_that);
      case SupersetWorkoutItem() when superset != null:
        return superset(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SingleWorkoutItem value) single,
    required TResult Function(SupersetWorkoutItem value) superset,
  }) {
    final _that = this;
    switch (_that) {
      case SingleWorkoutItem():
        return single(_that);
      case SupersetWorkoutItem():
        return superset(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SingleWorkoutItem value)? single,
    TResult? Function(SupersetWorkoutItem value)? superset,
  }) {
    final _that = this;
    switch (_that) {
      case SingleWorkoutItem() when single != null:
        return single(_that);
      case SupersetWorkoutItem() when superset != null:
        return superset(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Exercise exercise)? single,
    TResult Function(List<Exercise> exercises)? superset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SingleWorkoutItem() when single != null:
        return single(_that.exercise);
      case SupersetWorkoutItem() when superset != null:
        return superset(_that.exercises);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Exercise exercise) single,
    required TResult Function(List<Exercise> exercises) superset,
  }) {
    final _that = this;
    switch (_that) {
      case SingleWorkoutItem():
        return single(_that.exercise);
      case SupersetWorkoutItem():
        return superset(_that.exercises);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Exercise exercise)? single,
    TResult? Function(List<Exercise> exercises)? superset,
  }) {
    final _that = this;
    switch (_that) {
      case SingleWorkoutItem() when single != null:
        return single(_that.exercise);
      case SupersetWorkoutItem() when superset != null:
        return superset(_that.exercises);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class SingleWorkoutItem implements WorkoutItem {
  const SingleWorkoutItem({required this.exercise, String? $type})
      : $type = $type ?? 'single';
  factory SingleWorkoutItem.fromJson(Map<String, dynamic> json) =>
      _$SingleWorkoutItemFromJson(json);

  final Exercise exercise;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of WorkoutItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SingleWorkoutItemCopyWith<SingleWorkoutItem> get copyWith =>
      _$SingleWorkoutItemCopyWithImpl<SingleWorkoutItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SingleWorkoutItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SingleWorkoutItem &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, exercise);

  @override
  String toString() {
    return 'WorkoutItem.single(exercise: $exercise)';
  }
}

/// @nodoc
abstract mixin class $SingleWorkoutItemCopyWith<$Res>
    implements $WorkoutItemCopyWith<$Res> {
  factory $SingleWorkoutItemCopyWith(
          SingleWorkoutItem value, $Res Function(SingleWorkoutItem) _then) =
      _$SingleWorkoutItemCopyWithImpl;
  @useResult
  $Res call({Exercise exercise});

  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class _$SingleWorkoutItemCopyWithImpl<$Res>
    implements $SingleWorkoutItemCopyWith<$Res> {
  _$SingleWorkoutItemCopyWithImpl(this._self, this._then);

  final SingleWorkoutItem _self;
  final $Res Function(SingleWorkoutItem) _then;

  /// Create a copy of WorkoutItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? exercise = null,
  }) {
    return _then(SingleWorkoutItem(
      exercise: null == exercise
          ? _self.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
    ));
  }

  /// Create a copy of WorkoutItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<$Res> get exercise {
    return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
      return _then(_self.copyWith(exercise: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class SupersetWorkoutItem implements WorkoutItem {
  const SupersetWorkoutItem({required List<Exercise> exercises, String? $type})
      : _exercises = exercises,
        $type = $type ?? 'superset';
  factory SupersetWorkoutItem.fromJson(Map<String, dynamic> json) =>
      _$SupersetWorkoutItemFromJson(json);

  final List<Exercise> _exercises;
  List<Exercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of WorkoutItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SupersetWorkoutItemCopyWith<SupersetWorkoutItem> get copyWith =>
      _$SupersetWorkoutItemCopyWithImpl<SupersetWorkoutItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SupersetWorkoutItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SupersetWorkoutItem &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_exercises));

  @override
  String toString() {
    return 'WorkoutItem.superset(exercises: $exercises)';
  }
}

/// @nodoc
abstract mixin class $SupersetWorkoutItemCopyWith<$Res>
    implements $WorkoutItemCopyWith<$Res> {
  factory $SupersetWorkoutItemCopyWith(
          SupersetWorkoutItem value, $Res Function(SupersetWorkoutItem) _then) =
      _$SupersetWorkoutItemCopyWithImpl;
  @useResult
  $Res call({List<Exercise> exercises});
}

/// @nodoc
class _$SupersetWorkoutItemCopyWithImpl<$Res>
    implements $SupersetWorkoutItemCopyWith<$Res> {
  _$SupersetWorkoutItemCopyWithImpl(this._self, this._then);

  final SupersetWorkoutItem _self;
  final $Res Function(SupersetWorkoutItem) _then;

  /// Create a copy of WorkoutItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? exercises = null,
  }) {
    return _then(SupersetWorkoutItem(
      exercises: null == exercises
          ? _self._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ));
  }
}

// dart format on
