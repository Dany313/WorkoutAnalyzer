import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../bloc/workout_cubit.dart';
import '../bloc/workout_state.dart';
import '../../domain/entities/workout_plan.dart';

class WorkoutPlansPage extends StatelessWidget {
  const WorkoutPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('I Miei Piani di Allenamento')),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Inizializzazione...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text('Errore: $msg')),
            loaded: (plans) {
              if (plans.isEmpty) {
                return const Center(
                    child: Text('Nessun piano trovato. Creane uno nuovo!'));
              }
              return ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return ListTile(
                    title: Text(plan.name),
                    subtitle: Text('${plan.sessions.length} sedute'),
                    onTap: () => context.push('/plan/${plan.id}', extra: plan),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<WorkoutCubit>().deletePlan(plan.id);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePlanDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreatePlanDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo Piano'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nome del piano'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final newPlan = WorkoutPlan(
                  id: const Uuid().v4(),
                  name: controller.text,
                  sessions: [],
                );
                context.read<WorkoutCubit>().savePlan(newPlan);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Crea'),
          ),
        ],
      ),
    );
  }
}
