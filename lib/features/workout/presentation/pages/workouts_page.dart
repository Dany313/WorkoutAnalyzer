import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_state.dart';

import '../widget/add_workout_dialog.dart';

class WorkoutsPage extends StatelessWidget {
  final String planId;
  const WorkoutsPage({super.key, required this.planId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showDialog(
          context: context,
          builder: (context) => AddUpdateWorkoutDialog(planId: planId,),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          leading: IconButton(onPressed: () => context.go('/'), icon: Icon(Icons.keyboard_return)),
          title: const Text('Workouts')),
      body: Center(
        child: BlocConsumer<WorkoutBloc, WorkoutState>(
          listener: (context, state) {
            if (state.status == WorkoutStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                  ));}
          },
          builder: (context, state) {
            if (state.status == WorkoutStatus.loading) {
              return const CircularProgressIndicator();
            }else if (state.status == WorkoutStatus.reloading){
              context.read<WorkoutBloc>().add(GetWorkoutsEvent(planId: planId));
            } else if (state.status == WorkoutStatus.success) {
              return ListView.builder(
                itemCount: state.workouts.length,
                itemBuilder: (context, index) {
                  final workout = state.workouts[index];
                  return ListTile(
                    onTap: () =>
                        context.go('/workouts/${workout.id}/training', extra: workout),
                    title: Text(workout.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AddUpdateWorkoutDialog(oldName: workout.name, id: workout.id, planId: planId),
                        ), icon: Icon(Icons.edit)),
                        IconButton(onPressed: () => {
                          context.read<WorkoutBloc>().add(RemoveWorkoutEvent(id: workout.id))
                        }, icon: Icon(Icons.delete)),
                      ],
                    ),);
                },
              );
            } else if (state.status == WorkoutStatus.failure) {
              return Text('Error: ${state.errorMessage!}');
            }
            return const Text('Press the button to load workout plans.');
          },
        ),
      ),
    );
  }
}
