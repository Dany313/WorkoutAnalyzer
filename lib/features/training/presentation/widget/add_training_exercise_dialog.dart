import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/features/training/presentation/bloc/training_bloc.dart';
import 'package:workout_app/features/training/presentation/bloc/training_event.dart';
import 'package:workout_app/features/training/presentation/bloc/training_state.dart';

import '../../../../core/enums/muscle_goups.dart';

class AddTrainingExerciseDialog extends StatefulWidget {
  const AddTrainingExerciseDialog({super.key});

  @override
  State<AddTrainingExerciseDialog> createState() =>
      _AddTrainingExerciseDialogState();
}

class _AddTrainingExerciseDialogState
    extends State<AddTrainingExerciseDialog> {
  late TextEditingController _exerciseNameController;
  late TextEditingController _exerciseDescriptionController;
  final Map<MuscleGroups, int?> _selectedMuscles = {};

  @override
  void initState() {
    super.initState();
    _exerciseNameController = TextEditingController();
    _exerciseDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _exerciseNameController.dispose();
    _exerciseDescriptionController.dispose();
    super.dispose();
  }

  void _toggleMuscle(MuscleGroups muscle) {
    setState(() {
      if (_selectedMuscles.containsKey(muscle)) {
        context
            .read<TrainingBloc>()
            .add(TrainingExerciseTargetMuscleRemoved(muscle: muscle));
        _selectedMuscles.remove(muscle);
      } else {
        _selectedMuscles[muscle] = 50;
        context.read<TrainingBloc>().add(
          TrainingExerciseTargetMuscleAdded(muscle: muscle, percentage: 50),
        );
      }
    });
  }

  void _updateMusclePercentage(MuscleGroups muscle, int percentage) {
    setState(() {
      _selectedMuscles[muscle] = percentage;
      context.read<TrainingBloc>().add(
        TrainingExerciseTargetMusclePercentageChanged(
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
            child: BlocBuilder<TrainingBloc, TrainingState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aggiungi esercizio al training',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Usa esercizio esistente'),
                        value: state.useExistingExercise,
                        onChanged: (value) {
                          context.read<TrainingBloc>().add(
                                TrainingUseExistingExerciseToggled(
                                  useExisting: value,
                                ),
                              );
                        },
                      ),
                      if (state.useExistingExercise)
                        DropdownButtonFormField<String>(
                          initialValue: state.selectedExerciseId,
                          items: state.exercises
                              .map(
                                (exercise) => DropdownMenuItem(
                                  value: exercise.id,
                                  child: Text(exercise.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<TrainingBloc>().add(
                                    TrainingExerciseSelected(
                                      exerciseId: value,
                                    ),
                                  );
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Esercizio',
                            border: OutlineInputBorder(),
                          ),
                        )
                      else ...[
                        TextFormField(
                          controller: _exerciseNameController,
                          onChanged: (value) {
                            context.read<TrainingBloc>().add(
                                  TrainingExerciseNameChanged(value),
                                );
                          },
                          decoration: InputDecoration(
                            labelText: 'Nome esercizio',
                            errorText: state.exerciseName.displayError != null
                                ? 'Il nome è obbligatorio (min 6 caratteri)'
                                : null,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _exerciseDescriptionController,
                          onChanged: (value) {
                            context.read<TrainingBloc>().add(
                                  TrainingExerciseDescriptionChanged(value),
                                );
                          },
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Descrizione (opzionale)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Gruppi muscolari target',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ..._buildMuscleSelectionWidgets(),
                      ],
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context.read<TrainingBloc>().add(
                                TrainingSetsChanged(value),
                              );
                        },
                        decoration: InputDecoration(
                          labelText: 'Serie',
                          errorText: state.sets.displayError != null
                              ? 'Inserisci un numero valido'
                              : null,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context.read<TrainingBloc>().add(
                                TrainingRepsChanged(value),
                              );
                        },
                        decoration: InputDecoration(
                          labelText: 'Ripetizioni',
                          errorText: state.reps.displayError != null
                              ? 'Inserisci un numero valido'
                              : null,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context.read<TrainingBloc>().add(
                                TrainingRestChanged(value),
                              );
                        },
                        decoration: InputDecoration(
                          labelText: 'Recupero (secondi)',
                          errorText: state.restSeconds.displayError != null
                              ? 'Inserisci un numero valido'
                              : null,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context.read<TrainingBloc>().add(
                                TrainingRpeChanged(value),
                              );
                        },
                        decoration: InputDecoration(
                          labelText: 'RPE',
                          errorText: state.rpe.displayError != null
                              ? 'Inserisci un numero valido'
                              : null,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Annulla'),
                          ),
                          TextButton(
                            onPressed:
                                state.isValid &&
                                        state.status !=
                                            TrainingStatus.creating
                                    ? () {
                                        context.read<TrainingBloc>().add(
                                              const TrainingExerciseAdded(),
                                            );
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

  List<Widget> _buildMuscleSelectionWidgets() {
    return MuscleGroups.values.map((muscle) {
      final isSelected = _selectedMuscles.containsKey(muscle);
      final percentage = _selectedMuscles[muscle] ?? 50;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
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
                  items: const [25, 50, 75, 100]
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
