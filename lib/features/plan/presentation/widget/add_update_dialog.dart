import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plan_bloc.dart';
import '../bloc/plan_event.dart';
import '../bloc/plan_state.dart';

class AddUpdateDialog extends StatelessWidget {
  final String? id;
  final String? oldName;
  const AddUpdateDialog({super.key, this.oldName, this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          type: MaterialType.canvas,
          child: BlocBuilder<PlanBloc, PlanState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: oldName,
                    onChanged: (value) => context.read<PlanBloc>().add(PlanNameChanged(value)),
                    decoration: InputDecoration(
                      hintText: 'Inserisci nome del nuovo piano',
                      errorText: state.planName.displayError != null
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
                        onPressed: state.isValid && state.status != PlanStatus.creating
                            ? () {
                          if (oldName != null && id != null) {
                            context.read<PlanBloc>().add(UpdatePlanEvent(id: id!));
                          } else {
                            context.read<PlanBloc>().add(const AddPlanEvent());
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