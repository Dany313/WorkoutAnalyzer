import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../bloc/workout_cubit.dart';
import '../bloc/workout_state.dart';
import '../../domain/entities/workout_plan.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../utils/workout_import_utils.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/app_card.dart';
import '../../../../core/presentation/widgets/confirm_delete_dialog.dart';

class WorkoutPlansPage extends StatelessWidget {
  const WorkoutPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I Miei Piani'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: () => _showImportDialog(context),
            tooltip: 'Importa Piano JSON',
          ),
        ],
      ),
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                  onPressed: () {
                                    _showPlanBottomSheet(context, existingPlan: plan);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  onPressed: () async {
                                    final confirm = await ConfirmDeleteDialog.show(context);
                                    if (confirm && context.mounted) {
                                      context.read<WorkoutCubit>().deletePlan(plan.id);
                                    }
                                  },
                                ),
                              ],
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
        onPressed: () => _showPlanBottomSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuovo Piano'),
      ),
    );
  }

  void _showPlanBottomSheet(BuildContext context, {WorkoutPlan? existingPlan}) {
    final isEditing = existingPlan != null;
    final controller = TextEditingController(text: existingPlan?.name ?? '');
    
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
              isEditing ? 'Modifica Piano' : 'Nuovo Piano di Allenamento',
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
                  final newPlan = isEditing
                      ? existingPlan.copyWith(name: controller.text.trim())
                      : WorkoutPlan(
                          id: const Uuid().v4(),
                          name: controller.text.trim(),
                          sessions: [],
                        );
                  context.read<WorkoutCubit>().savePlan(newPlan);
                  Navigator.pop(ctx);
                }
              },
              child: Text(isEditing ? 'Salva Modifiche' : 'Crea Piano'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showImportDialog(BuildContext context) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Importa Piano'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Incolla qui il JSON del piano...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (textController.text.trim().isNotEmpty) {
                  Navigator.pop(ctx);
                  _processImportedJson(context, textController.text);
                }
              },
              child: const Text('Importa da Testo'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('oppure'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.file_upload),
              label: const Text('Carica da file...'),
              onPressed: () {
                Navigator.pop(ctx);
                _importFromFile(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importFromFile(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        if (context.mounted) {
          _processImportedJson(context, jsonString);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }
  }

  void _processImportedJson(BuildContext context, String jsonString) {
    try {
      final jsonData = jsonDecode(jsonString);
      final importedPlan = WorkoutPlan.fromJson(jsonData);
      final newPlan = clonePlanWithNewIds(importedPlan);
      
      context.read<WorkoutCubit>().savePlan(newPlan);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Piano importato con successo!')),
      );
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  void _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Errore durante l'importazione: $error"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
