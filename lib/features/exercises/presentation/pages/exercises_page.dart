import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/exercise_bloc.dart';
import '../bloc/exercise_event.dart';
import '../bloc/exercise_state.dart';
import '../widget/add_exercise_dialog.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showDialog(
          context: context,
          builder: (context) => AddUpdateExerciseDialog(),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          leading: IconButton(onPressed: () => context.go('/'), icon: Icon(Icons.keyboard_return)),
          title: const Text('Exercises')),
      body: Center(
        child: BlocConsumer<ExerciseBloc, ExerciseState>(
          listener: (context, state) {
            if (state.status == ExerciseStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                  ));}
          },
          builder: (context, state) {
            if (state.status == ExerciseStatus.loading) {
              return const CircularProgressIndicator();
            }else if (state.status == ExerciseStatus.reloading){
              context.read<ExerciseBloc>().add(GetExercisesEvent());
            } else if (state.status == ExerciseStatus.success) {
              return ListView.builder(
                itemCount: state.exercises.length,
                itemBuilder: (context, index) {
                  final workout = state.exercises[index];
                  return ListTile(
                    title: Text(workout.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AddUpdateExerciseDialog(oldName: workout.name, id: workout.id),
                        ), icon: Icon(Icons.edit)),
                        IconButton(onPressed: () => {
                          context.read<ExerciseBloc>().add(RemoveExerciseEvent(id: workout.id))
                        }, icon: Icon(Icons.delete)),
                      ],
                    ),);
                },
              );
            } else if (state.status == ExerciseStatus.failure) {
              return Text('Error: ${state.errorMessage!}');
            }
            return const Text('Press the button to load workout plans.');
          },
        ),
      ),
    );
  }
}
