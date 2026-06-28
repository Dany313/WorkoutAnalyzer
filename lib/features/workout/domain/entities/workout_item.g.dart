// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleWorkoutItem _$SingleWorkoutItemFromJson(Map<String, dynamic> json) =>
    SingleWorkoutItem(
      exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SingleWorkoutItemToJson(SingleWorkoutItem instance) =>
    <String, dynamic>{
      'exercise': instance.exercise,
      'runtimeType': instance.$type,
    };

SupersetWorkoutItem _$SupersetWorkoutItemFromJson(Map<String, dynamic> json) =>
    SupersetWorkoutItem(
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SupersetWorkoutItemToJson(
        SupersetWorkoutItem instance) =>
    <String, dynamic>{
      'exercises': instance.exercises,
      'runtimeType': instance.$type,
    };
