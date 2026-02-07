import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/features/exercises/domain/entity/exercise_entity.dart';
import 'package:workout_app/features/training/presentation/bloc/training_bloc.dart';
import 'package:workout_app/features/training/presentation/bloc/training_event.dart';
import 'package:workout_app/features/training/presentation/bloc/training_state.dart';
import 'package:workout_app/features/training/presentation/widget/add_training_exercise_dialog.dart';

class TrainingPage extends StatefulWidget {
  final String workoutId;
  final String? workoutName;

  const TrainingPage({
    super.key,
    required this.workoutId,
    this.workoutName,
  });

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  void initState() {
    super.initState();
    context.read<TrainingBloc>().add(
          TrainingLoadRequested(workoutId: widget.workoutId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddTrainingExerciseDialog(),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_return),
        ),
        title: Text(widget.workoutName ?? 'Training'),
      ),
      body: Center(
        child: BlocConsumer<TrainingBloc, TrainingState>(
          listener: (context, state) {
            if (state.status == TrainingStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Errore')),
              );
            }
          },
          builder: (context, state) {
            if (state.status == TrainingStatus.loading) {
              return const CircularProgressIndicator();
            } else if (state.status == TrainingStatus.reloading) {
              context.read<TrainingBloc>().add(
                    TrainingLoadRequested(workoutId: widget.workoutId),
                  );
            } else if (state.status == TrainingStatus.success) {
              if (state.trainingExercises.isEmpty) {
                return const Text('Nessun esercizio ancora aggiunto.');
              }
              return ListView.builder(
                itemCount: state.trainingExercises.length,
                itemBuilder: (context, index) {
                  final trainingExercise = state.trainingExercises[index];
                  final exercise = _findExercise(
                    state.exercises,
                    trainingExercise.exerciseId,
                  );
                  return ListTile(
                    title: Text(exercise?.name ?? 'Esercizio ${trainingExercise.exerciseId}'),
                    subtitle: Text(
                      'Serie: ${trainingExercise.sets} • Ripetizioni: ${trainingExercise.reps}\n'
                      'Recupero: ${trainingExercise.restSeconds}s • RPE: ${trainingExercise.rpe}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<TrainingBloc>().add(
                              TrainingExerciseRemoved(id: trainingExercise.id),
                            );
                      },
                    ),
                  );
                },
              );
            } else if (state.status == TrainingStatus.failure) {
              return Text('Error: ${state.errorMessage ?? 'Errore'}');
            }
            return const Text('Carica gli esercizi di training.');
          },
        ),
      ),
    );
  }

  ExerciseEntity? _findExercise(
    List<ExerciseEntity> exercises,
    String exerciseId,
  ) {
    for (final exercise in exercises) {
      if (exercise.id == exerciseId) {
        return exercise;
      }
    }
    return null;
  }
}
