import 'package:flutter/material.dart';
import 'package:workout_analyzer/components/custom_list_component.dart';
import 'package:workout_analyzer/model/week.dart';
import 'package:workout_analyzer/model/workout_detail.dart';
import '../model/exercise.dart';
import '../model/workout_plan.dart';
import 'exercises_page.dart';

class WorkoutPlansPage extends StatefulWidget {
  const WorkoutPlansPage({super.key});

  @override
  State<WorkoutPlansPage> createState() => _WorkoutPlansPageState();
}

class _WorkoutPlansPageState extends State<WorkoutPlansPage> {
  late List<WorkoutPlan> _workoutPlans;

  @override
  void initState() {
    super.initState();
    _workoutPlans = [
      WorkoutPlan(name: 'SCHEDA 1', exercises: [
        Exercise(name: 'ESERCIZIO 1', weeks: [
          Week(workoutDetails: [
            WorkoutDetail(repetitions: 6, weight: 30),
            WorkoutDetail(repetitions: 5, weight: 40),
            WorkoutDetail(repetitions: 4, weight: 50),
          ])
        ])
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schede Allenamento"),
      ),
      body: CustomListComponent(
        items: _workoutPlans.map((e) => e.name).toList(),
        onTap: (index) {
          // Naviga alla seconda pagina passando l'elemento selezionato
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExercisesPage(
                    selectedPlan: _workoutPlans[index].exercises,
                    planName: _workoutPlans[index].name,),
            ),
          );
        },
        onEdit: (index, newName) {
          setState(() {
            _workoutPlans[index].name = newName;
          });
        },
        onRemove: (index) {
          setState(() {
            _workoutPlans.removeAt(index);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _workoutPlans.add(WorkoutPlan(
                name: 'SCHEDA ${_workoutPlans.length + 1}', exercises: []));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
