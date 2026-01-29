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
            if (state.status == PlanStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                ));}
          },
          builder: (context, state) {
            if (state.status == PlanStatus.loading) {
              return const CircularProgressIndicator();
            } else if (state.status == PlanStatus.success) {
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
            } else if (state.status == PlanStatus.failure) {
              return Text('Error: ${state.errorMessage!}');
            }
            return const Text('Press the button to load workout plans.');
          },
        ),
      ),
    );
  }
}
