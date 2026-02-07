import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/muscle_goups.dart';
import '../bloc/exercise_bloc.dart';
import '../bloc/exercise_event.dart';
import '../bloc/exercise_state.dart';

class AddUpdateExerciseDialog extends StatefulWidget {
  final String? id;
  final String? oldName;
  final String? oldDescription;
  final Map<MuscleGroups, int>? oldTargetMuscles;

  const AddUpdateExerciseDialog({
    super.key,
    this.oldName,
    this.oldDescription,
    this.oldTargetMuscles,
    this.id,
  });

  @override
  State<AddUpdateExerciseDialog> createState() =>
      _AddUpdateExerciseDialogState();
}

class _AddUpdateExerciseDialogState extends State<AddUpdateExerciseDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late Map<MuscleGroups, int?> _selectedMuscles;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.oldName ?? '');
    _descriptionController = TextEditingController(
      text: widget.oldDescription ?? '',
    );
    _selectedMuscles =
        widget.oldTargetMuscles != null
            ? Map.from(widget.oldTargetMuscles!)
            : {};

    // Inizializza il form con i valori iniziali se è un update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.oldName != null) {
        context.read<ExerciseBloc>().add(ExerciseNameChanged(widget.oldName!));
      }
      if (widget.oldDescription != null) {
        context.read<ExerciseBloc>().add(
          ExerciseDescriptionChanged(widget.oldDescription!),
        );
      }
      if (widget.oldTargetMuscles != null) {
        widget.oldTargetMuscles!.forEach((muscle, percentage) {
          context.read<ExerciseBloc>().add(
            ExerciseTargetMuscleAdded(muscle: muscle, percentage: percentage),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleMuscle(MuscleGroups muscle) {
    setState(() {
      if (_selectedMuscles.containsKey(muscle)) {
        context.read<ExerciseBloc>().add(
          ExerciseTargetMuscleRemoved(muscle: muscle),
        );
        _selectedMuscles.remove(muscle);
      } else {
        _selectedMuscles[muscle] = 50; // Default percentage
        context.read<ExerciseBloc>().add(
          ExerciseTargetMuscleAdded(muscle: muscle, percentage: 50),
        );
      }
    });
  }

  void _updateMusclePercentage(MuscleGroups muscle, int percentage) {
    setState(() {
      _selectedMuscles[muscle] = percentage;
      context.read<ExerciseBloc>().add(
        ExerciseTargetMusclePercentageChanged(
          muscle: muscle,
          percentage: percentage,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Material(
          type: MaterialType.canvas,
          child: SingleChildScrollView(
            child: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.id != null
                            ? 'Modifica Esercizio'
                            : 'Nuovo Esercizio',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      // Nome esercizio
                      TextFormField(
                        controller: _nameController,
                        onChanged: (value) {
                          context.read<ExerciseBloc>().add(
                            ExerciseNameChanged(value),
                          );
                        },
                        decoration: InputDecoration(
                          labelText: 'Nome esercizio',
                          hintText: 'Inserisci nome dell\'esercizio',
                          errorText:
                              state.exerciseName.displayError != null
                                  ? 'Il campo non può essere vuoto o minore di 6 caratteri'
                                  : null,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Descrizione (opzionale)
                      TextFormField(
                        controller: _descriptionController,
                        onChanged: (value) {
                          context.read<ExerciseBloc>().add(
                            ExerciseDescriptionChanged(value),
                          );
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Descrizione (opzionale)',
                          hintText: 'Inserisci una descrizione dell\'esercizio',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sezione Gruppi Muscolari
                      Text(
                        'Gruppi Muscolari Target',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      ..._buildMuscleSelectionWidgets(context, state),
                      const SizedBox(height: 24),
                      // Pulsanti
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Annulla'),
                          ),
                          TextButton(
                            onPressed:
                                state.isValid &&
                                        state.status != ExerciseStatus.creating
                                    ? () {
                                      if (widget.oldName != null &&
                                          widget.id != null) {
                                        context.read<ExerciseBloc>().add(
                                          UpdateExerciseEvent(id: widget.id!),
                                        );
                                      } else {
                                        context.read<ExerciseBloc>().add(
                                          AddExerciseEvent(),
                                        );
                                      }
                                      Navigator.pop(context);
                                    }
                                    : null,
                            child: const Text('Conferma'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMuscleSelectionWidgets(
    BuildContext context,
    ExerciseState state,
  ) {
    return MuscleGroups.values.map((muscle) {
      final isSelected = _selectedMuscles.containsKey(muscle);
      final percentage = _selectedMuscles[muscle] ?? 50;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (_) => _toggleMuscle(muscle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getMuscleDisplayName(muscle),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (isSelected)
                DropdownButton<int>(
                  value: percentage,
                  items:
                      const [25, 50, 75, 100]
                          .map(
                            (p) =>
                                DropdownMenuItem(value: p, child: Text('$p%')),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _updateMusclePercentage(muscle, value);
                    }
                  },
                ),
            ],
          ),
        ),
      );
    }).toList();
  }

  String _getMuscleDisplayName(MuscleGroups muscle) {
    switch (muscle) {
      case MuscleGroups.chest:
        return 'Petto';
      case MuscleGroups.back:
        return 'Schiena';
      case MuscleGroups.shoulders:
        return 'Spalle';
      case MuscleGroups.biceps:
        return 'Bicipiti';
      case MuscleGroups.triceps:
        return 'Tricipiti';
      case MuscleGroups.legs:
        return 'Gambe';
      case MuscleGroups.abs:
        return 'Addominali';
    }
  }
}
