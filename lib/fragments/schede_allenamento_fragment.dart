import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/schedeAllenamento.dart';
import '../pages/scheda_page.dart';

class SchedeAllenamentoFragment extends StatefulWidget {
  const SchedeAllenamentoFragment({super.key});

  @override
  State<SchedeAllenamentoFragment> createState() => _SchedeAllenamentoFragmentState();
}

class _SchedeAllenamentoFragmentState extends State<SchedeAllenamentoFragment> {

  SchedeAllenamento schedeAllenamentoList = SchedeAllenamento();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ListView.builder(
        itemCount: schedeAllenamentoList.allenamenti.length, // Numero di elementi nella lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.list), // Icona accanto a ciascun elemento
            title: Text(schedeAllenamentoList.getAllenamento(index)), // Testo dell'elemento
            subtitle: Text('Sottotitolo di ${schedeAllenamentoList.getAllenamento(index)}'), // Sottotitolo
            trailing: Icon(Icons.arrow_forward), // Icona sulla destra
            onTap: () {
              // Naviga alla seconda pagina
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SchedaPage(nomeScheda: schedeAllenamentoList.getAllenamento(index))),
              );
            },
          );
        },
      ),
        floatingActionButton : FloatingActionButton(
          onPressed: () {
            setState(() {
              schedeAllenamentoList.aggiungiAllenamento('SCHEDA ${schedeAllenamentoList.allenamenti.length+1}');
            });
          },
          child: const Icon(Icons.add),
        ),
    );
  }
}
