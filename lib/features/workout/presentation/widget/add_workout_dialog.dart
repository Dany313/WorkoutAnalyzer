import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_event.dart';

import '../bloc/workout_bloc.dart';
import '../bloc/workout_state.dart';


class AddUpdateWorkoutDialog extends StatelessWidget {
  final String? id;
  final String? oldName;
  final String planId;
  const AddUpdateWorkoutDialog({required this.planId,super.key, this.oldName, this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          type: MaterialType.canvas,
          child: BlocBuilder<WorkoutBloc, WorkoutState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: oldName,
                    onChanged: (value) => context.read<WorkoutBloc>().add(WorkoutNameChanged(value)),
                    decoration: InputDecoration(
                      hintText: 'Inserisci nome del nuovo workout',
                      errorText: state.workoutName.displayError != null
                          ? 'Il campo non può essere vuoto o minore di 6 caratteri'
                          : null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }
                        , child: Text('Annulla'),
                      ),
                      TextButton(
                        onPressed: state.isValid && state.status != WorkoutStatus.creating
                            ? () {
                          if (oldName != null && id != null) {
                            context.read<WorkoutBloc>().add(UpdateWorkoutEvent(id: id!));
                          } else {
                            context.read<WorkoutBloc>().add(AddWorkoutEvent(planId: planId));
                          }
                          Navigator.pop(context);
                        }
                            : null, child: Text('Conferma'),

                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}