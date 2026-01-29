import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plan_bloc.dart';
import '../bloc/plan_event.dart';
import '../bloc/plan_state.dart';
import '../widget/add_plan_dialog.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showDialog(
              context: context,
              builder: (context) => const AddPlanDialog(),
            ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Workout Plans')),
      body: Center(
        child: BlocConsumer<PlanBloc, PlanState>(
          listener: (context, state) {
            if (state is PlanErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ));}
          },
          builder: (context, state) {
            if (state is PlanLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is PlanLoadedState) {
              return ListView.builder(
                itemCount: state.plans.length,
                itemBuilder: (context, index) {
                  final plan = state.plans[index];
                  return ListTile(
                      title: Text(plan.name),
                  trailing: IconButton(onPressed: () => {
                    context.read<PlanBloc>().add(RemovePlanEvent(id: plan.id))
                  }, icon: Icon(Icons.delete)),);
                },
              );
            } else if (state is PlanErrorState) {
              return Text('Error: ${state.message}');
            }
            return const Text('Press the button to load workout plans.');
          },
        ),
      ),
    );
  }
}
