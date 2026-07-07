import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../bloc/workout_cubit.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/workout_session.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/app_card.dart';
import '../../../../core/presentation/widgets/confirm_delete_dialog.dart';

class WorkoutPlanDetailPage extends StatefulWidget {
  final WorkoutPlan plan;
  const WorkoutPlanDetailPage({super.key, required this.plan});

  @override
  State<WorkoutPlanDetailPage> createState() => _WorkoutPlanDetailPageState();
}

class _WorkoutPlanDetailPageState extends State<WorkoutPlanDetailPage> {
  late WorkoutPlan _plan;

  @override
  void initState() {
    super.initState();
    _plan = widget.plan;
  }

  void _updatePlan(WorkoutPlan updatedPlan) {
    setState(() {
      _plan = updatedPlan;
    });
    context.read<WorkoutCubit>().savePlan(_plan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_plan.name)),
      body: _plan.sessions.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.calendar_month,
              title: 'Nessuna seduta',
              message: 'Aggiungi la prima seduta al tuo piano!',
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 80),
              itemCount: _plan.sessions.length,
              itemBuilder: (context, index) {
                final session = _plan.sessions[index];
                return AppCard(
                  onTap: () {
                    context
                        .push('/session/${session.id}', extra: session)
                        .then((updatedSession) {
                      if (updatedSession != null &&
                          updatedSession is WorkoutSession) {
                        final sessions =
                            List<WorkoutSession>.from(_plan.sessions);
                        final sIndex = sessions
                            .indexWhere((s) => s.id == updatedSession.id);
                        if (sIndex != -1) {
                          sessions[sIndex] = updatedSession;
                          _updatePlan(_plan.copyWith(sessions: sessions));
                        }
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.view_day,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              session.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${session.items.length} esercizi/superserie',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () {
                              _showSessionBottomSheet(context, existingSession: session, index: index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () async {
                              final confirm = await ConfirmDeleteDialog.show(context);
                              if (confirm && context.mounted) {
                                final newSessions =
                                    List<WorkoutSession>.from(_plan.sessions)
                                      ..removeAt(index);
                                _updatePlan(_plan.copyWith(sessions: newSessions));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSessionBottomSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuova Seduta'),
      ),
    );
  }

  void _showSessionBottomSheet(BuildContext context, {WorkoutSession? existingSession, int? index}) {
    final isEditing = existingSession != null && index != null;
    final controller = TextEditingController(text: existingSession?.name ?? '');
    
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
              isEditing ? 'Modifica Seduta' : 'Nuova Seduta',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nome seduta',
                hintText: 'es. Petto e Tricipiti',
                prefixIcon: Icon(Icons.fitness_center),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  if (isEditing) {
                    final updatedSession = existingSession.copyWith(name: controller.text.trim());
                    final newSessions = List<WorkoutSession>.from(_plan.sessions);
                    newSessions[index] = updatedSession;
                    _updatePlan(_plan.copyWith(sessions: newSessions));
                  } else {
                    final newSession = WorkoutSession(
                      id: const Uuid().v4(),
                      name: controller.text.trim(),
                      items: [],
                    );
                    final newSessions = List<WorkoutSession>.from(_plan.sessions)
                      ..add(newSession);
                    _updatePlan(_plan.copyWith(sessions: newSessions));
                  }
                  Navigator.pop(ctx);
                }
              },
              child: Text(isEditing ? 'Salva Modifiche' : 'Aggiungi Seduta'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

