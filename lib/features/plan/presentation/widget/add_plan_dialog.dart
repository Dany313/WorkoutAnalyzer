import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plan_bloc.dart';
import '../bloc/plan_event.dart';
import '../bloc/plan_state.dart';

class AddPlanDialog extends StatelessWidget {
  const AddPlanDialog({super.key});

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
                    // Invia l'evento ad ogni modifica
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
                        // Il bottone si abilita/disabilita in tempo reale!
                        onPressed: () {
                          Navigator.pop(context);
                        }
                        , child: Text('Annulla'),

                      ),
                      TextButton(
                        // Il bottone si abilita/disabilita in tempo reale!
                        onPressed: state.isValid && state.status != PlanStatus.creating
                            ? () {
                          context.read<PlanBloc>().add(const AddPlanEvent());
                          Navigator.pop(context);
                        }
                            : null, child: Text('Crea'),

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