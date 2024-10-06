import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/esercizi.dart';
import '../model/schedeAllenamento.dart';

class SchedaPage extends StatefulWidget {
  final String nomeScheda;
  const SchedaPage({super.key, required this.nomeScheda});

  @override
  State<SchedaPage> createState() => _SchedaPageState();
}

class _SchedaPageState extends State<SchedaPage> {
  Esercizi eserciziList = Esercizi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeScheda),
        leading: IconButton(
          onPressed: () {
            // Torna indietro alla pagina precedente
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),

        ),
      ),
      body:ListView.builder(
        itemCount: eserciziList.esercizi.length, // Numero di elementi nella lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.list), // Icona accanto a ciascun elemento
            title: Text(eserciziList.getEsercizio(index)), // Testo dell'elemento
            subtitle: Text('Sottotitolo di ${eserciziList.getEsercizio(index)}'), // Sottotitolo
            trailing: Icon(Icons.arrow_forward), // Icona sulla destra
            onTap: () {
              // Azione quando si clicca sull'elemento
              print('${eserciziList.getEsercizio(index)} selezionato');
            },
          );
        },
      ),
      floatingActionButton : FloatingActionButton(
        onPressed: () {
          setState(() {
            eserciziList.aggiungiEsercizio('ESERCIZIO ${eserciziList.esercizi.length+1}');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
