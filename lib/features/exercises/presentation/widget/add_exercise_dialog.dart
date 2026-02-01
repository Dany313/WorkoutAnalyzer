import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/exercise_bloc.dart';
import '../bloc/exercise_event.dart';
import '../bloc/exercise_state.dart';


class AddUpdateExerciseDialog extends StatelessWidget {
  final String? id;
  final String? oldName;
  const AddUpdateExerciseDialog({super.key, this.oldName, this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          type: MaterialType.canvas,
          child: BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: oldName,
                    onChanged: (value) => context.read<ExerciseBloc>().add(ExerciseNameChanged(value)),
                    decoration: InputDecoration(
                      hintText: 'Inserisci nome del nuovo workout',
                      errorText: state.exerciseName.displayError != null
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
                        onPressed: state.isValid && state.status != ExerciseStatus.creating
                            ? () {
                          if (oldName != null && id != null) {
                            context.read<ExerciseBloc>().add(UpdateExerciseEvent(id: id!));
                          } else {
                            context.read<ExerciseBloc>().add(AddExerciseEvent());
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