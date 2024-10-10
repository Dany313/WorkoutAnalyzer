import 'package:workout_analyzer/model/week.dart';

class Exercise {
  String name; // Nome dell'esercizio
  List<Week> weeks; // Lista di settimane per ogni esercizio

  Exercise({
    required this.name,
    required this.weeks,
  });
}