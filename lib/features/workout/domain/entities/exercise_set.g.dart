// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) => _ExerciseSet(
      reps: (json['reps'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      restTimeSeconds: (json['restTimeSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$ExerciseSetToJson(_ExerciseSet instance) =>
    <String, dynamic>{
      'reps': instance.reps,
      'weight': instance.weight,
      'restTimeSeconds': instance.restTimeSeconds,
    };
