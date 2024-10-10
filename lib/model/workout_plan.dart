import 'exercise.dart';

class WorkoutPlan {
  String name; // Nome della scheda di allenamento
  List<Exercise> exercises; // Lista di esercizi nella scheda

  WorkoutPlan({
    required this.name,
    required this.exercises,
  });
}