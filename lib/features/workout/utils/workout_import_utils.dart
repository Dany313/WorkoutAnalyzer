import 'package:uuid/uuid.dart';
import '../domain/entities/workout_plan.dart';
import '../domain/entities/workout_item.dart';

WorkoutPlan clonePlanWithNewIds(WorkoutPlan originalPlan) {
  const uuid = Uuid();

  return originalPlan.copyWith(
    id: uuid.v4(),
    sessions: originalPlan.sessions.map((session) {
      return session.copyWith(
        id: uuid.v4(),
        items: session.items.map((item) {
          return item.map(
            single: (singleItem) {
              return WorkoutItem.single(
                exercise: singleItem.exercise.copyWith(
                  id: uuid.v4(),
                ),
              );
            },
            superset: (supersetItem) {
              return WorkoutItem.superset(
                exercises: supersetItem.exercises.map((exercise) {
                  return exercise.copyWith(
                    id: uuid.v4(),
                  );
                }).toList(),
              );
            },
          );
        }).toList(),
      );
    }).toList(),
  );
}
