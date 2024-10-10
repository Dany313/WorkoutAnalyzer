import 'package:flutter/material.dart';

// Widget riutilizzabile per visualizzare una lista di ListTile
class CustomListComponent extends StatefulWidget {
  final List<String> items;
  final Function(int, String) onEdit;
  final Function(int) onRemove;
  final Function(int) onTap;

  const CustomListComponent({
    super.key,
    required this.items,
    required this.onRemove,
    required this.onEdit,
    required this.onTap,
  });

  @override
  State<CustomListComponent> createState() => _CustomListComponentState();
}

class _CustomListComponentState extends State<CustomListComponent> {
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
                        widget.onEdit(index, newValue);
                        _isEditingNome =
                            false; // Exit edit mode after submission
                      });
                    },
                  )
                : Text(widget.items[index]),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  widget.onRemove(index);
                });
              },
              icon: const Icon(Icons.delete),
            ),
            // Icona sulla destra
            onTap: () => _isEditingNome
                ? setState(() {
                    _isEditingNome = !_isEditingNome;
                  })
                : widget.onTap(index),
          );
        },
      ),
    );
  }
}
