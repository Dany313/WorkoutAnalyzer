import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/workout_detail.dart';

class WorkoutDetailComponent extends StatefulWidget {
  final WorkoutDetail detail;
  final Function(int) onUpdateReps; // Callback per aggiornare le ripetizioni

  const WorkoutDetailComponent({
    super.key,
    required this.onUpdateReps, required this.detail,
  });

  @override
  State<WorkoutDetailComponent> createState() => _WorkoutDetailComponentState();
}

class _WorkoutDetailComponentState extends State<WorkoutDetailComponent> {
  bool _isEditingReps = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("reps :"),
          (_isEditingReps)
              ? Expanded(
                  child: TextField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onSubmitted: (newValue) {
                      setState(() {
                        widget.onUpdateReps(int.parse(newValue)); // Usa la callback per aggiornare le ripetizioni
                        _isEditingReps = !_isEditingReps; // Exit edit mode after submission
                      });
                    },
                  ),
                )
              : TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditingReps = !_isEditingReps;
                    });
                  },
                  child: Text(widget.detail.repetitions.toString())),
          Text("kg :"),
          TextButton(onPressed: () {}, child: Text("${widget.detail.weight}")),
        ],
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
    );
  }
}
