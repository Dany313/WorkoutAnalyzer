import 'package:flutter/material.dart';

// Widget riutilizzabile per visualizzare una lista di ListTile
class CustomListWidget extends StatefulWidget {
  final List<String> items;
  final Function(String) onTap;

  const CustomListWidget({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  State<CustomListWidget> createState() => _CustomListWidgetState();
}

class _CustomListWidgetState extends State<CustomListWidget> {
  bool _isEditingNome = false;
  late int _idEditNome;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditingNome = false;
        });
      },
      child: ListView.builder(
        itemCount: widget.items.length, // Numero di elementi nella lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: IconButton(
              onPressed: () {
                setState(() {
                  _idEditNome = index;
                  _isEditingNome = !_isEditingNome;
                });
              },
              icon: const Icon(Icons.edit),
            ),
            // Icona accanto a ciascun elemento
            title: (_isEditingNome && (_idEditNome == index))
                ? TextField(
                    autofocus: true,
                    onSubmitted: (newValue) {
                      setState(() {
                        widget.items[index] = newValue;
                        _isEditingNome =
                            false; // Exit edit mode after submission
                      });
                    },
                  )
                : Text(widget.items[index]),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  widget.items.removeAt(index);
                });
              },
              icon: const Icon(Icons.delete),
            ),
            // Icona sulla destra
            onTap: () => _isEditingNome
                ? setState(() {
                    _isEditingNome = !_isEditingNome;
                  })
                : widget.onTap(widget.items[index]),
          );
        },
      ),
    );
  }
}
