import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/esercizi.dart';

class EserciziFragment extends StatefulWidget {
  const EserciziFragment({super.key});

  @override
  State<EserciziFragment> createState() => _EserciziFragmentState();
}

class _EserciziFragmentState extends State<EserciziFragment> {
  Esercizi eserciziList = Esercizi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
