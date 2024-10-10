import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_analyzer/pages/exercise_detail_page.dart';

import '../components/custom_list_component.dart';
import '../model/exercise.dart';

class ExercisesPage extends StatefulWidget {
  final List<Exercise> selectedPlan;
  final String planName;
  const ExercisesPage({super.key, required this.selectedPlan, required this.planName});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planName),
      ),
      body: CustomListComponent(items: widget.selectedPlan.map((e) => e.name).toList(),
        onRemove: (index ) {
          setState(() {
            widget.selectedPlan.removeAt(index);
          });
        },
        onEdit: (index , newName ) {
          setState(() {
            widget.selectedPlan[index].name = newName;
          });
        },
        onTap: (index ) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExerciseDetailPage(
                    selectedExercise: widget.selectedPlan[index].weeks,
                    exerciseName: widget.selectedPlan[index].name,),
            ),
          );
        },
        ),
      floatingActionButton : FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.selectedPlan.add(Exercise(
                name: 'ESERCIZIO ${widget.selectedPlan.length+1}',
                weeks: []));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
