// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) => _WorkoutPlan(
      id: json['id'] as String,
      name: json['name'] as String,
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => WorkoutSession.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutPlanToJson(_WorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sessions': instance.sessions,
    };
