import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../bloc/workout_cubit.dart';
import '../bloc/workout_state.dart';
import '../../domain/entities/workout_plan.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/app_card.dart';

class WorkoutPlansPage extends StatelessWidget {
  const WorkoutPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('I Miei Piani')),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Inizializzazione...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text('Errore: $msg')),
            loaded: (plans) {
              if (plans.isEmpty) {
                return const EmptyStateWidget(
                  icon: Icons.fitness_center,
                  title: 'Nessun piano trovato',
                  message: 'Inizia creando il tuo primo piano di allenamento!',
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 16, bottom: 80),
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      final plan = plans[index];
                      return AppCard(
                        onTap: () => context.push('/plan/${plan.id}', extra: plan),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.assignment,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan.name,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${plan.sessions.length} sedute',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.grey.shade600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                              onPressed: () {
                                context.read<WorkoutCubit>().deletePlan(plan.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePlanBottomSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuovo Piano'),
      ),
    );
  }

  void _showCreatePlanBottomSheet(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nuovo Piano di Allenamento',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nome del piano',
                hintText: 'es. Ipertrofia Base',
                prefixIcon: Icon(Icons.edit),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  final newPlan = WorkoutPlan(
                    id: const Uuid().v4(),
                    name: controller.text.trim(),
                    sessions: [],
                  );
                  context.read<WorkoutCubit>().savePlan(newPlan);
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Crea Piano'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
