import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../bloc/workout_cubit.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/workout_session.dart';

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
          ? const Center(child: Text('Nessuna seduta in questo piano.'))
          : ListView.builder(
              itemCount: _plan.sessions.length,
              itemBuilder: (context, index) {
                final session = _plan.sessions[index];
                return ListTile(
                  title: Text(session.name),
                  subtitle: Text('${session.items.length} esercizi/superserie'),
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      final newSessions =
                          List<WorkoutSession>.from(_plan.sessions)
                            ..removeAt(index);
                      _updatePlan(_plan.copyWith(sessions: newSessions));
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateSessionDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateSessionDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova Seduta'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
              hintText: 'Nome seduta (es. Petto-Tricipiti)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final newSession = WorkoutSession(
                  id: const Uuid().v4(),
                  name: controller.text,
                  items: [],
                );
                final newSessions = List<WorkoutSession>.from(_plan.sessions)
                  ..add(newSession);
                _updatePlan(_plan.copyWith(sessions: newSessions));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }
}
