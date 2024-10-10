import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_analyzer/entity/esercizio_dettaglio.dart';

class AllenamentoTile extends StatefulWidget {
  final EsercizioDettaglio esercizio;
  final Function(int) onUpdateReps; // Callback per aggiornare le ripetizioni

  const AllenamentoTile({
    super.key,
    required this.esercizio, required this.onUpdateReps,
  });

  @override
  State<AllenamentoTile> createState() => _AllenamentoTileState();
}

class _AllenamentoTileState extends State<AllenamentoTile> {
  bool _isEditingReps = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("Serie ${widget.esercizio.serie}"),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  child: Text(widget.esercizio.ripetizioni.toString())),
          Text("kg :"),
          TextButton(onPressed: () {}, child: Text("${widget.esercizio.peso}")),
        ],
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
    );
  }
}
