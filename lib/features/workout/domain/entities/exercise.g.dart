// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sets: (json['sets'] as List<dynamic>)
          .map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'sets': instance.sets,
    };
