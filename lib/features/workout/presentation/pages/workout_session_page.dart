import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/workout_session.dart';
import '../../domain/entities/workout_item.dart';
import '../../domain/entities/exercise.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/app_card.dart';
import '../../../../core/presentation/widgets/confirm_delete_dialog.dart';

class WorkoutSessionPage extends StatefulWidget {
  final WorkoutSession session;
  const WorkoutSessionPage({super.key, required this.session});

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  late WorkoutSession _session;

  @override
  void initState() {
    super.initState();
    _session = widget.session;
  }

  void _updateSession() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, _session);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_session.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _session),
          ),
        ),
        body: _session.items.isEmpty
            ? const EmptyStateWidget(
                icon: Icons.list_alt,
                title: 'Nessun esercizio',
                message: 'Aggiungi il tuo primo esercizio o superserie a questa seduta.',
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 80),
                itemCount: _session.items.length,
                itemBuilder: (context, index) {
                  final item = _session.items[index];
                  return item.map(
                    single: (singleItem) => _buildSingleExerciseCard(singleItem.exercise, index),
                    superset: (supersetItem) => _buildSupersetCard(supersetItem.exercises, index),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddExerciseOptions(context),
          icon: const Icon(Icons.add),
          label: const Text('Aggiungi'),
        ),
      ),
    );
  }

  Widget _buildSingleExerciseCard(Exercise exercise, int itemIndex) {
    return AppCard(
      onTap: () async {
        final updatedItem = await context.push('/item', extra: _session.items[itemIndex]);
        if (updatedItem != null && updatedItem is WorkoutItem) {
          final newItems = List<WorkoutItem>.from(_session.items);
          newItems[itemIndex] = updatedItem;
          _session = _session.copyWith(items: newItems);
          _updateSession();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              '${itemIndex + 1}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (exercise.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    exercise.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${exercise.sets.length} serie',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
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
                    _showCreateExerciseBottomSheet(existingExercise: exercise, itemIndex: itemIndex);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () async {
                    final confirm = await ConfirmDeleteDialog.show(context);
                    if (confirm && context.mounted) {
                      _session = _session.copyWith(
                        items: List.from(_session.items)..removeAt(itemIndex),
                      );
                      _updateSession();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget _buildSupersetCard(List<Exercise> exercises, int itemIndex) {
    final names = exercises.map((e) => e.name).join(' + ');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          width: 2,
        ),
      ),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: InkWell(
        onTap: () async {
          final updatedItem = await context.push('/item', extra: _session.items[itemIndex]);
          if (updatedItem != null && updatedItem is WorkoutItem) {
            final newItems = List<WorkoutItem>.from(_session.items);
            newItems[itemIndex] = updatedItem;
            _session = _session.copyWith(items: newItems);
            _updateSession();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.link,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUPERSERIE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      names.isEmpty ? 'Nessun esercizio' : names,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () async {
                  final confirm = await ConfirmDeleteDialog.show(context);
                  if (confirm && context.mounted) {
                    _session = _session.copyWith(
                      items: List.from(_session.items)..removeAt(itemIndex),
                    );
                    _updateSession();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddExerciseOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.fitness_center, color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text('Esercizio Singolo', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Aggiungi un singolo esercizio'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showCreateExerciseBottomSheet();
                },
              ),
              const Divider(indent: 72),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.link, color: Theme.of(context).colorScheme.secondary),
                ),
                title: const Text('Superserie', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Crea un gruppo di esercizi concatenati'),
                onTap: () {
                  Navigator.pop(ctx);
                  final newItems = List<WorkoutItem>.from(_session.items)
                    ..add(const WorkoutItem.superset(exercises: []));
                  _session = _session.copyWith(items: newItems);
                  _updateSession();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateExerciseBottomSheet({Exercise? existingExercise, int? itemIndex}) {
    final isEditing = existingExercise != null && itemIndex != null;
    final nameController = TextEditingController(text: existingExercise?.name ?? '');
    final descController = TextEditingController(text: existingExercise?.description ?? '');
    
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
              isEditing ? 'Modifica Esercizio' : 'Nuovo Esercizio',
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome esercizio',
                hintText: 'es. Panca piana',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Note (opzionale)',
                hintText: 'es. Focus sul petto alto',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isNotEmpty) {
                  if (isEditing) {
                    final exercise = existingExercise.copyWith(
                      name: nameController.text.trim(),
                      description: descController.text.trim(),
                    );
                    final newItems = List<WorkoutItem>.from(_session.items);
                    newItems[itemIndex] = WorkoutItem.single(exercise: exercise);
                    _session = _session.copyWith(items: newItems);
                  } else {
                    final exercise = Exercise(
                      id: const Uuid().v4(),
                      name: nameController.text.trim(),
                      description: descController.text.trim(),
                      sets: [],
                    );
                    final newItems = List<WorkoutItem>.from(_session.items);
                    newItems.add(WorkoutItem.single(exercise: exercise));
                    _session = _session.copyWith(items: newItems);
                  }
                  _updateSession();
                  Navigator.pop(ctx);
                }
              },
              child: Text(isEditing ? 'Salva Modifiche' : 'Aggiungi Esercizio'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
