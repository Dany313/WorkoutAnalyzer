import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/workout_detail_component.dart';
import '../model/week.dart';
import '../model/workout_detail.dart';

class ExerciseDetailPage extends StatefulWidget {
  final List<Week> selectedExercise;
  final String exerciseName;

  const ExerciseDetailPage({
    super.key,
    required this.selectedExercise,
    required this.exerciseName,
  });

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  // Controlla quali pannelli sono espansi
  List<bool> _expandedPanels = [];

  @override
  void initState() {
    super.initState();
    // Inizializza la lista di pannelli espansi con tutti chiusi
    _expandedPanels =
        List.generate(widget.selectedExercise.length, (_) => false);
  }

  void _addWorkoutDetail(int weekIndex) {
    setState(() {
      WorkoutDetail newDetail = WorkoutDetail(
        repetitions: 0,      // Imposta un valore predefinito per le ripetizioni
        weight: 0,         // Imposta un valore predefinito per il peso
      );

      // Aggiungi il nuovo WorkoutDetail alla settimana specificata
      widget.selectedExercise[weekIndex].workoutDetails.add(newDetail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _expandedPanels[panelIndex] = !_expandedPanels[panelIndex];
              });
            },
            children: widget.selectedExercise.asMap().entries.map((entry) {
              int index = entry.key;
              Week week = entry.value;

              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Settimana ${index + 1}'),
                  );
                },
                body: Column(
                  children: [
                    // Aggiungi i dettagli dell'allenamento
                    ...week.workoutDetails.map<Widget>((WorkoutDetail detail) {
                      return WorkoutDetailComponent(
                        onUpdateReps: (newReps) {
                          detail.repetitions = newReps;
                        },
                        detail: detail, onUpdateWeight: (newWeight ) {
                          detail.weight = newWeight;
                      }, onDelete: () {
                        setState(() {
                          week.workoutDetails.remove(detail);
                        });
                      },
                      );
                    }),
                    // Aggiungi un IconButton per aggiungere un nuovo WorkoutDetail
                    IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: 'Aggiungi Dettaglio Allenamento',
                      onPressed: () => _addWorkoutDetail(index), // Chiama la funzione per aggiungere un nuovo dettaglio
                    ),
                  ],
                ),
                isExpanded: _expandedPanels[index],
              );
            }).toList(), // Conversione a List<Widget>
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _expandedPanels.add(false);
            widget.selectedExercise.add(Week(workoutDetails: []));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
