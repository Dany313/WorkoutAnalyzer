import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/workout_item.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';

class WorkoutItemDetailPage extends StatefulWidget {
  final WorkoutItem item;
  const WorkoutItemDetailPage({super.key, required this.item});

  @override
  State<WorkoutItemDetailPage> createState() => _WorkoutItemDetailPageState();
}

class _WorkoutItemDetailPageState extends State<WorkoutItemDetailPage> {
  late WorkoutItem _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  void _updateItem(WorkoutItem newItem) {
    setState(() {
      _item = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, _item);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_item.map(
            single: (s) => s.exercise.name,
            superset: (_) => 'Dettaglio Superserie',
          )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _item),
          ),
        ),
        body: _item.map(
          single: (s) => _buildSingleDetail(s.exercise),
          superset: (s) => _buildSupersetDetail(s.exercises),
        ),
      ),
    );
  }

  Widget _buildSingleDetail(Exercise exercise) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (exercise.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(exercise.description, style: const TextStyle(fontSize: 16)),
          ),
        const Text('Serie:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...exercise.sets.asMap().entries.map((entry) {
          final setIndex = entry.key;
          final set = entry.value;
          return Card(
            child: ListTile(
              title: Text('Serie ${setIndex + 1}'),
              subtitle: Text('${set.reps} rip, ${set.weight} kg, rec ${set.restTimeSeconds}s'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  final newSets = List<ExerciseSet>.from(exercise.sets)..removeAt(setIndex);
                  _updateItem(WorkoutItem.single(exercise: exercise.copyWith(sets: newSets)));
                },
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => _showAddSetDialog(exercise),
          icon: const Icon(Icons.add),
          label: const Text('Aggiungi Serie'),
        ),
      ],
    );
  }

  Widget _buildSupersetDetail(List<Exercise> exercises) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ...exercises.asMap().entries.map((entry) {
          final exIndex = entry.key;
          final exercise = entry.value;
          return Card(
            color: Colors.blue.withOpacity(0.05),
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(exercise.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final newExercises = List<Exercise>.from(exercises)..removeAt(exIndex);
                          _updateItem(WorkoutItem.superset(exercises: newExercises));
                        },
                      ),
                    ],
                  ),
                  if (exercise.description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(exercise.description),
                    ),
                  ...exercise.sets.asMap().entries.map((setEntry) {
                    final setIndex = setEntry.key;
                    final set = setEntry.value;
                    return ListTile(
                      dense: true,
                      title: Text('Serie ${setIndex + 1}'),
                      subtitle: Text('${set.reps} rip, ${set.weight} kg, rec ${set.restTimeSeconds}s'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final newSets = List<ExerciseSet>.from(exercise.sets)..removeAt(setIndex);
                          final newExercise = exercise.copyWith(sets: newSets);
                          final newExercises = List<Exercise>.from(exercises);
                          newExercises[exIndex] = newExercise;
                          _updateItem(WorkoutItem.superset(exercises: newExercises));
                        },
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: () => _showAddSetDialog(exercise, supersetExerciseIndex: exIndex),
                    icon: const Icon(Icons.add),
                    label: const Text('Aggiungi Serie'),
                  ),
                ],
              ),
            ),
          );
        }),
        ElevatedButton.icon(
          onPressed: _showCreateExerciseDialog,
          icon: const Icon(Icons.add),
          label: const Text('Aggiungi Esercizio alla Superserie'),
        ),
      ],
    );
  }

  void _showAddSetDialog(Exercise exercise, {int? supersetExerciseIndex}) {
    final repsController = TextEditingController();
    final weightController = TextEditingController();
    final restController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova Serie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: repsController,
              decoration: const InputDecoration(labelText: 'Ripetizioni'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: restController,
              decoration: const InputDecoration(labelText: 'Recupero (secondi)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              final reps = int.tryParse(repsController.text) ?? 0;
              final weight = double.tryParse(weightController.text) ?? 0.0;
              final rest = int.tryParse(restController.text) ?? 0;
              
              final newSet = ExerciseSet(reps: reps, weight: weight, restTimeSeconds: rest);
              final newSets = List<ExerciseSet>.from(exercise.sets)..add(newSet);
              final newExercise = exercise.copyWith(sets: newSets);
              
              if (supersetExerciseIndex == null) {
                _updateItem(WorkoutItem.single(exercise: newExercise));
              } else {
                if (_item is SupersetWorkoutItem) {
                  final newExercises = List<Exercise>.from((_item as SupersetWorkoutItem).exercises);
                  newExercises[supersetExerciseIndex] = newExercise;
                  _updateItem(WorkoutItem.superset(exercises: newExercises));
                }
              }
              Navigator.pop(ctx);
            },
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }

  void _showCreateExerciseDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo Esercizio Superserie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Nome esercizio'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'Descrizione (opzionale)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && _item is SupersetWorkoutItem) {
                final exercise = Exercise(
                  id: const Uuid().v4(),
                  name: nameController.text,
                  description: descController.text,
                  sets: [],
                );
                final newExercises = List<Exercise>.from((_item as SupersetWorkoutItem).exercises)..add(exercise);
                _updateItem(WorkoutItem.superset(exercises: newExercises));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }
}
