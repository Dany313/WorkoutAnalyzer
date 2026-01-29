
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plan_bloc.dart';
import '../bloc/plan_event.dart';

class AddPlanDialog extends StatefulWidget {
  const AddPlanDialog({super.key});

  @override
  State<AddPlanDialog> createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Il campo non può essere vuoto o minore di 6 caratteri';
                }
                return null;
      },
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Inserisci nome del nuovo piano',
              ),
            ),
            IconButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<PlanBloc>()
                    .add(AddPlanEvent(
                    name: controller.value.text)
                );
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
          icon: const Icon(Icons.add))

          ],
        ),
      ),
    );
  }
}
