// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseSet {
  int get reps;
  double get weight;
  int get restTimeSeconds;

  /// Create a copy of ExerciseSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseSetCopyWith<ExerciseSet> get copyWith =>
      _$ExerciseSetCopyWithImpl<ExerciseSet>(this as ExerciseSet, _$identity);

  /// Serializes this ExerciseSet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseSet &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.restTimeSeconds, restTimeSeconds) ||
                other.restTimeSeconds == restTimeSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reps, weight, restTimeSeconds);

  @override
  String toString() {
    return 'ExerciseSet(reps: $reps, weight: $weight, restTimeSeconds: $restTimeSeconds)';
  }
}

/// @nodoc
abstract mixin class $ExerciseSetCopyWith<$Res> {
  factory $ExerciseSetCopyWith(
          ExerciseSet value, $Res Function(ExerciseSet) _then) =
      _$ExerciseSetCopyWithImpl;
  @useResult
  $Res call({int reps, double weight, int restTimeSeconds});
}

/// @nodoc
class _$ExerciseSetCopyWithImpl<$Res> implements $ExerciseSetCopyWith<$Res> {
  _$ExerciseSetCopyWithImpl(this._self, this._then);

  final ExerciseSet _self;
  final $Res Function(ExerciseSet) _then;

  /// Create a copy of ExerciseSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reps = null,
    Object? weight = null,
    Object? restTimeSeconds = null,
  }) {
    return _then(ExerciseSet(
      reps: null == reps
          ? _self.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      restTimeSeconds: null == restTimeSeconds
          ? _self.restTimeSeconds
          : restTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseSet].
extension ExerciseSetPatterns on ExerciseSet {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ExerciseSet value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseSet() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_ExerciseSet value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseSet():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ExerciseSet value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseSet() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int reps, double weight, int restTimeSeconds)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseSet() when $default != null:
        return $default(_that.reps, _that.weight, _that.restTimeSeconds);
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
  TResult when<TResult extends Object?>(
    TResult Function(int reps, double weight, int restTimeSeconds) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseSet():
        return $default(_that.reps, _that.weight, _that.restTimeSeconds);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int reps, double weight, int restTimeSeconds)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseSet() when $default != null:
        return $default(_that.reps, _that.weight, _that.restTimeSeconds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseSet implements ExerciseSet {
  const _ExerciseSet(
      {required this.reps,
      required this.weight,
      required this.restTimeSeconds});
  factory _ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetFromJson(json);

  @override
  final int reps;
  @override
  final double weight;
  @override
  final int restTimeSeconds;

  /// Create a copy of ExerciseSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseSetCopyWith<_ExerciseSet> get copyWith =>
      __$ExerciseSetCopyWithImpl<_ExerciseSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseSetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseSet &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.restTimeSeconds, restTimeSeconds) ||
                other.restTimeSeconds == restTimeSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reps, weight, restTimeSeconds);

  @override
  String toString() {
    return 'ExerciseSet(reps: $reps, weight: $weight, restTimeSeconds: $restTimeSeconds)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseSetCopyWith<$Res>
    implements $ExerciseSetCopyWith<$Res> {
  factory _$ExerciseSetCopyWith(
          _ExerciseSet value, $Res Function(_ExerciseSet) _then) =
      __$ExerciseSetCopyWithImpl;
  @override
  @useResult
  $Res call({int reps, double weight, int restTimeSeconds});
}

/// @nodoc
class __$ExerciseSetCopyWithImpl<$Res> implements _$ExerciseSetCopyWith<$Res> {
  __$ExerciseSetCopyWithImpl(this._self, this._then);

  final _ExerciseSet _self;
  final $Res Function(_ExerciseSet) _then;

  /// Create a copy of ExerciseSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? reps = null,
    Object? weight = null,
    Object? restTimeSeconds = null,
  }) {
    return _then(_ExerciseSet(
      reps: null == reps
          ? _self.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      restTimeSeconds: null == restTimeSeconds
          ? _self.restTimeSeconds
          : restTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
