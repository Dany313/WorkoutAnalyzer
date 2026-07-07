import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/workout_item.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';
import '../../../../core/presentation/widgets/app_card.dart';

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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 100.0),
      children: [
        if (exercise.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              exercise.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade700,
                  ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Serie',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: () => _showAddSetBottomSheet(exercise),
              icon: const Icon(Icons.add),
              label: const Text('Aggiungi'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (exercise.sets.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                'Nessuna serie aggiunta.\nClicca "Aggiungi" per iniziare.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
          ),
        ...exercise.sets.asMap().entries.map((entry) {
          final setIndex = entry.key;
          final set = entry.value;
          return AppCard(
            margin: const EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.zero,
            child: InkWell(
              onTap: () => _showAddSetBottomSheet(exercise, setIndexToEdit: setIndex, existingSet: set),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${setIndex + 1}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSetStat('${set.reps}', 'Rip'),
                          _buildSetStat('${set.weight}', 'kg'),
                          _buildSetStat('${set.restTimeSeconds}s', 'Rec'),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () {
                        final newSets = List<ExerciseSet>.from(exercise.sets)..removeAt(setIndex);
                        _updateItem(WorkoutItem.single(exercise: exercise.copyWith(sets: newSets)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSetStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildSupersetDetail(List<Exercise> exercises) {
    return ListView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 100.0),
      children: [
        ...exercises.asMap().entries.map((entry) {
          final exIndex = entry.key;
          final exercise = entry.value;
          return AppCard(
            color: Theme.of(context).colorScheme.surface,
            margin: const EdgeInsets.only(bottom: 24.0),
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    border: Border(
                      bottom: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exercise.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              _showCreateExerciseBottomSheet(existingExercise: exercise, supersetExerciseIndex: exIndex);
                            },
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              final newExercises = List<Exercise>.from(exercises)..removeAt(exIndex);
                              _updateItem(WorkoutItem.superset(exercises: newExercises));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (exercise.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            exercise.description,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ...exercise.sets.asMap().entries.map((setEntry) {
                        final setIndex = setEntry.key;
                        final set = setEntry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () => _showAddSetBottomSheet(exercise, supersetExerciseIndex: exIndex, setIndexToEdit: setIndex, existingSet: set),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      'S${setIndex + 1}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${set.reps} rip • ${set.weight} kg • rec ${set.restTimeSeconds}s',
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      final newSets = List<ExerciseSet>.from(exercise.sets)..removeAt(setIndex);
                                      final newExercise = exercise.copyWith(sets: newSets);
                                      final newExercises = List<Exercise>.from(exercises);
                                      newExercises[exIndex] = newExercise;
                                      _updateItem(WorkoutItem.superset(exercises: newExercises));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _showAddSetBottomSheet(exercise, supersetExerciseIndex: exIndex),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Aggiungi Serie'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        ElevatedButton.icon(
          onPressed: _showCreateExerciseBottomSheet,
          icon: const Icon(Icons.add),
          label: const Text('Nuovo Esercizio in Superserie'),
        ),
      ],
    );
  }

  void _showAddSetBottomSheet(Exercise exercise, {int? supersetExerciseIndex, int? setIndexToEdit, ExerciseSet? existingSet}) {
    final isEditing = setIndexToEdit != null && existingSet != null;
    final repsController = TextEditingController(text: existingSet?.reps.toString() ?? '');
    final weightController = TextEditingController(text: existingSet?.weight.toString() ?? '');
    final restController = TextEditingController(text: existingSet?.restTimeSeconds.toString() ?? '');

    if (isEditing) {
      repsController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: repsController.text.length,
      );
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? 'Modifica Serie' : 'Nuova Serie per ${exercise.name}',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: repsController,
                    decoration: const InputDecoration(labelText: 'Ripetizioni'),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onTap: () => repsController.selection = TextSelection(baseOffset: 0, extentOffset: repsController.text.length),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: 'Peso (kg)'),
                    keyboardType: TextInputType.number,
                    onTap: () => weightController.selection = TextSelection(baseOffset: 0, extentOffset: weightController.text.length),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: restController,
              decoration: const InputDecoration(
                labelText: 'Recupero (secondi)',
                hintText: 'es. 90',
              ),
              keyboardType: TextInputType.number,
              onTap: () => restController.selection = TextSelection(baseOffset: 0, extentOffset: restController.text.length),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final reps = int.tryParse(repsController.text) ?? 0;
                final weight = double.tryParse(weightController.text) ?? 0.0;
                final rest = int.tryParse(restController.text) ?? 0;
                final newSet = ExerciseSet(reps: reps, weight: weight, restTimeSeconds: rest);
                final newSets = List<ExerciseSet>.from(exercise.sets);
                if (isEditing) {
                  newSets[setIndexToEdit] = newSet;
                } else {
                  newSets.add(newSet);
                }
                
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
              child: Text(isEditing ? 'Salva Modifiche' : 'Aggiungi Serie'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showCreateExerciseBottomSheet({Exercise? existingExercise, int? supersetExerciseIndex}) {
    final isEditing = existingExercise != null && supersetExerciseIndex != null;
    final nameController = TextEditingController(text: existingExercise?.name ?? '');
    final descController = TextEditingController(text: existingExercise?.description ?? '');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditing ? 'Modifica Esercizio' : 'Nuovo Esercizio in Superserie',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Nome esercizio'),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'Note (opzionale)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isNotEmpty && _item is SupersetWorkoutItem) {
                  if (isEditing) {
                    final newExercises = List<Exercise>.from((_item as SupersetWorkoutItem).exercises);
                    newExercises[supersetExerciseIndex] = existingExercise.copyWith(
                      name: nameController.text.trim(),
                      description: descController.text.trim(),
                    );
                    _updateItem(WorkoutItem.superset(exercises: newExercises));
                  } else {
                    final exercise = Exercise(
                      id: const Uuid().v4(),
                      name: nameController.text.trim(),
                      description: descController.text.trim(),
                      sets: [],
                    );
                    final newExercises = List<Exercise>.from((_item as SupersetWorkoutItem).exercises)..add(exercise);
                    _updateItem(WorkoutItem.superset(exercises: newExercises));
                  }
                  Navigator.pop(ctx);
                }
              },
              child: Text(isEditing ? 'Salva Modifiche' : 'Aggiungi'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
