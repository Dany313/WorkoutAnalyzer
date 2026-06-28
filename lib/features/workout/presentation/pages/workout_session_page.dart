import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/workout_session.dart';
import '../../domain/entities/workout_item.dart';
import '../../domain/entities/exercise.dart';

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
            ? const Center(child: Text('Nessun esercizio nella seduta.'))
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _session.items.length,
                itemBuilder: (context, index) {
                  final item = _session.items[index];
                  return item.map(
                    single: (singleItem) => _buildSingleExerciseCard(singleItem.exercise, index),
                    superset: (supersetItem) => _buildSupersetCard(supersetItem.exercises, index),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddExerciseOptions(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSingleExerciseCard(Exercise exercise, int itemIndex) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(exercise.description.isEmpty ? '${exercise.sets.length} serie' : '${exercise.description}\n${exercise.sets.length} serie'),
        isThreeLine: exercise.description.isNotEmpty,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _session = _session.copyWith(
              items: List.from(_session.items)..removeAt(itemIndex),
            );
            _updateSession();
          },
        ),
        onTap: () async {
          final updatedItem = await context.push('/item', extra: _session.items[itemIndex]);
          if (updatedItem != null && updatedItem is WorkoutItem) {
            final newItems = List<WorkoutItem>.from(_session.items);
            newItems[itemIndex] = updatedItem;
            _session = _session.copyWith(items: newItems);
            _updateSession();
          }
        },
      ),
    );
  }

  Widget _buildSupersetCard(List<Exercise> exercises, int itemIndex) {
    final names = exercises.map((e) => e.name).join(' + ');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.blue.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: const Text('SUPERSERIE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        subtitle: Text(names.isEmpty ? 'Nessun esercizio' : names),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _session = _session.copyWith(
              items: List.from(_session.items)..removeAt(itemIndex),
            );
            _updateSession();
          },
        ),
        onTap: () async {
          final updatedItem = await context.push('/item', extra: _session.items[itemIndex]);
          if (updatedItem != null && updatedItem is WorkoutItem) {
            final newItems = List<WorkoutItem>.from(_session.items);
            newItems[itemIndex] = updatedItem;
            _session = _session.copyWith(items: newItems);
            _updateSession();
          }
        },
      ),
    );
  }

  void _showAddExerciseOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Aggiungi Esercizio Singolo'),
              onTap: () {
                Navigator.pop(ctx);
                _showCreateExerciseDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Aggiungi Superserie vuota'),
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
    );
  }

  void _showCreateExerciseDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo Esercizio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Nome esercizio'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'Descrizione (opzionale)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final exercise = Exercise(
                  id: const Uuid().v4(),
                  name: nameController.text,
                  description: descController.text,
                  sets: [],
                );
                
                final newItems = List<WorkoutItem>.from(_session.items);
                newItems.add(WorkoutItem.single(exercise: exercise));
                _session = _session.copyWith(items: newItems);
                _updateSession();
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
