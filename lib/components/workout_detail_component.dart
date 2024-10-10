import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/workout_detail.dart';

class WorkoutDetailComponent extends StatefulWidget {
  final WorkoutDetail detail;
  final Function(int) onUpdateReps; // Callback per aggiornare le ripetizioni
  final Function(double) onUpdateWeight;
  final Function() onDelete;
  const WorkoutDetailComponent({
    super.key,
    required this.onUpdateReps, required this.detail, required this.onUpdateWeight, required this.onDelete,
  });

  @override
  State<WorkoutDetailComponent> createState() => _WorkoutDetailComponentState();
}

class _WorkoutDetailComponentState extends State<WorkoutDetailComponent> {
  bool _isEditingReps = false;
  bool _isEditingWeight = false;

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
          (_isEditingWeight)
              ? Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              onSubmitted: (newValue) {
                setState(() {
                  widget.onUpdateWeight(double.parse(newValue)); // Usa la callback per aggiornare le ripetizioni
                  _isEditingWeight = !_isEditingWeight; // Exit edit mode after submission
                });
              },
            ),
          )
              : TextButton(
              onPressed: () {
                setState(() {
                  _isEditingWeight = !_isEditingWeight;
                });
              },
              child: Text(widget.detail.weight.toString())),
        ],
      ),
      trailing: IconButton(
          onPressed: () {
              widget.onDelete();
          },
          icon: Icon(Icons.delete)),
    );
  }
}
